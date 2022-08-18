module classfile

/*
attribute_info {
    u2 attribute_name_index;
    u4 attribute_length;
    u1 info[attribute_length];
}
*/
interface AttributeInfo {
mut:
	read_info(mut reader ClassReader) !
}

fn (mut reader ClassReader) read_attributes(pool &ConstantPool) ![]AttributeInfo {
	attribute_len := int(reader.read_u16())
	mut attributes := []AttributeInfo{cap: attribute_len}
	for _ in 0 .. attribute_len {
		attributes << reader.read_attribute(pool)!
	}
	return attributes
}

fn (mut reader ClassReader) read_attribute(pool &ConstantPool) !AttributeInfo {
	attr_name_index := reader.read_u16()
	attr_name := pool.get_utf8(attr_name_index)!
	attr_len := reader.read_u32()
	mut attr := new_attribute_info(attr_name, attr_len, pool)
	attr.read_info(mut reader)!
	return attr
}

fn new_attribute_info(attr_name string, attr_len u32, pool &ConstantPool) AttributeInfo {
	return match attr_name {
		'Code' {
			AttributeInfo(CodeAttribute{
				pool: pool
			})
		}
		'ConstantValue' {
			AttributeInfo(ConstantValueAttribute{})
		}
		'SourceFile' {
			AttributeInfo(SourceFileAttribute{
				pool: pool
			})
		}
		else {
			AttributeInfo(UnparsedAttribute{
				name: attr_name
				len: attr_len
			})
		}
	}
}

struct MarkerAttribute {}

fn (mut attr MarkerAttribute) read_info(mut reader ClassReader) ! {}

/*
Deprecated_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
}
*/
struct DeprecatedAttribute {
	MarkerAttribute
}

/*
Synthetic_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
}
*/
struct SyntheticAttribute {
	MarkerAttribute
}

/*
SourceFile_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 sourcefile_index;
}
*/
struct SourceFileAttribute {
	pool &ConstantPool [required]
mut:
	source_file_index u16
}

fn (mut attr SourceFileAttribute) read_info(mut reader ClassReader) ! {
	attr.source_file_index = reader.read_u16()
}

fn (attr &SourceFileAttribute) file_name() !string {
	return attr.pool.get_utf8(attr.source_file_index)!
}

/*
ConstantValue_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 constantvalue_index;
}
*/
struct ConstantValueAttribute {
mut:
	constant_value_index u16
}

fn (mut attr ConstantValueAttribute) read_info(mut reader ClassReader) ! {
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
	pool &ConstantPool [required]
mut:
	max_stack       u16
	max_locals      u16
	code            []u8 = []u8{}
	exception_table []ExceptionTableEntry = []ExceptionTableEntry{}
	attributes      []AttributeInfo
}

struct ExceptionTableEntry {
	start_pc   u16
	end_pc     u16
	handler_pc u16
	catch_type u16
}

fn (mut attr CodeAttribute) read_info(mut reader ClassReader) ! {
	attr.max_stack = reader.read_u16()
	attr.max_locals = reader.read_u16()
	code_len := reader.read_u32()
	attr.code = reader.read_u8_array(code_len)
	attr.exception_table = reader.read_exception_table()
	attr.attributes = reader.read_attributes(attr.pool)!
}

fn (mut reader ClassReader) read_exception_table() []ExceptionTableEntry {
	len := int(reader.read_u16())
	mut table := []ExceptionTableEntry{cap: len}
	for _ in 0 .. len {
		table << ExceptionTableEntry{reader.read_u16(), reader.read_u16(), reader.read_u16(), reader.read_u16()}
	}
	return table
}

/*
attribute_info {
    u2 attribute_name_index;
    u4 attribute_length;
    u1 info[attribute_length];
}
*/
struct UnparsedAttribute {
mut:
	name string [required]
	len  u32    [required]
	info []u8 = []u8{}
}

fn (mut attr UnparsedAttribute) read_info(mut reader ClassReader) ! {
	attr.info = reader.read_u8_array(attr.len)
}

fn (attr &UnparsedAttribute) info() []u8 {
	return attr.info
}
