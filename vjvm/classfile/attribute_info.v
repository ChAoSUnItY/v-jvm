module classfile

interface AttributeInfo {
	read_info(mut reader ClassReader)
}

fn (mut reader ClassReader) read(pool &ConstantPool) []AttributeInfo {
	attribute_len := reader.read_u16()
	attributes := []AttributeInfo{len: attribute_len}
	for i in 0 .. attribute_len {
		attributes[i] = reader.read_attribute(pool)
	}
	return attributes
}

fn (mut reader ClassReader) read_attribute(pool &ConstantPool) AttributeInfo {
	attr_name_index := reader.read_u16()
	attr_name := pool.get_utf8(attr_name_index)
	attr_len := reader.read_u32()
	attr := new_attribute_info(attr_name, attr_len, pool)
	attr.read_info(mut reader)
	return attr
}

fn new_attribute_info(attr_name string, attr_len u32, pool &ConstantPool) AttributeInfo {
	return match attr_name {
		'Code' {
			CodeAttribute{pool}
		}
		else {
			UnparsedAttribute{attr_name, attr_len}
		}
	}
}

struct MarkerAttribute {}

fn (mut attr MarkerAttribute) read_info(mut reader ClassReader) {}

/*
Deprecated_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
}
*/
type DeprecatedAttribute = MarkerAttribute

/*
Synthetic_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
}
*/
type SyntheticAttribute = MarkerAttribute

/*
SourceFile_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 sourcefile_index;
}
*/
struct SourceFileAttribute {
	pool              &ConstantPool [required]
	source_file_index u16 = 0
}

fn (mut attr SourceFileAttribute) read_info(mut reader ClassReader) {
	attr.source_file_index = reader.read_u16()
}

fn (attr &SourceFileAttribute) file_name() string {
	return attr.pool.get_utf8(attr.source_file_index)
}

/*
ConstantValue_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 constantvalue_index;
}
*/
struct ConstantValueAttribute {
	constant_value_index u16 = 0
}

fn (mut attr ConstantValueAttribute) read_info(mut reader ClassReader) {
	attr.constant_value_index = reader.read_u16()
}

fn (attr &ConstantValueAttribute) index() u16 {
	return attr.constant_value_index
}

/*
Code_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 max_stack;
    u2 max_locals;
    u4 code_length;
    u1 code[code_length];
    u2 exception_table_length;
    {   u2 start_pc;
        u2 end_pc;
        u2 handler_pc;
        u2 catch_type;
    } exception_table[exception_table_length];
    u2 attributes_count;
    attribute_info attributes[attributes_count];
}
*/
struct CodeAttribute {
	pool            &ConstantPool          [required]
	max_stack       u16  = 0
	max_locals      u16  = 0
	code            []u8 = []u8{}
	exception_table []&ExceptionTableEntry = []&ExceptionTableEntry{}
	attributes      []AttributeInfo
}

struct ExceptionTableEntry {
	start_pc   u16 = 0
	end_pc     u16 = 0
	handler_pc u16 = 0
	catch_type u16 = 0
}

fn (mut attr CodeAttribute) read_info(mut reader ClassReader) {
	attr.max_stack = reader.read_u16()
	attr.max_locals = reader.read_u16()
	code_len := reader.read_u32()
	attr.code = reader.read_u8_array(code_len)
	attr.exception_table = reader.read_exception_table()
	attr.attributes = reader.read_attributes(attr.pool)
}

/*
attribute_info {
    u2 attribute_name_index;
    u4 attribute_length;
    u1 info[attribute_length];
}
*/
struct UnparsedAttribute {
	name string [required]
	len  u32    [required]
	info []u8 = []u8{}
}

fn (mut attr UnparsedAttribute) read_info(mut reader ClassReader) {
	attr.info = reader.read_u8_array(attr.len)
}

fn (attr &UnparsedAttribute) info() []u8 {
	return attr.info
}
