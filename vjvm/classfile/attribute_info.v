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
		'Deprecated' {
			AttributeInfo(DeprecatedAttribute{})
		}
		'Synthetic' {
			AttributeInfo(SyntheticAttribute{})
		}
		'Exceptions' {
			AttributeInfo(ExceptionAttribute{})
		}
		'ConstantValue' {
			AttributeInfo(ConstantValueAttribute{})
		}
		'LineNumberTable' {
			AttributeInfo(LineNumberTableAttribute{})
		}
		'LocalVariableTable' {
			AttributeInfo(LocalVariableTableAttribute{})
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
BootstrapMethods_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 num_bootstrap_methods;
    {   u2 bootstrap_method_ref;
        u2 num_bootstrap_arguments;
        u2 bootstrap_arguments[num_bootstrap_arguments];
    } bootstrap_methods[num_bootstrap_methods];
}
*/
struct BootstrapMethodsAttribute {
mut:
	bootstrap_methods []BootstrapMethod = []BootstrapMethod{}
}

fn (mut attr BootstrapMethodsAttribute) read_info(mut reader ClassReader) ! {
	len := reader.read_u16()
	attr.bootstrap_methods = []BootstrapMethod{cap: int(len)}

	for _ in 0 .. len {
		method_ref := reader.read_u16()
		arguments := reader.read_u16_array()
		attr.bootstrap_methods << BootstrapMethod{method_ref, arguments}
	}
}

struct BootstrapMethod {
	bootstrap_method_ref u16
	bootstrap_arguments  []u16
}

/*
EnclosingMethod_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 class_index;
    u2 method_index;
}
*/
struct EnclosingMethodAttribute {
	pool &ConstantPool [required]
mut:
	class_index  u16
	method_index u16
}

fn (mut attr EnclosingMethodAttribute) read_info(mut reader ClassReader) ! {
	attr.class_index = reader.read_u16()
	attr.method_index = reader.read_u16()
}

fn (attr &EnclosingMethodAttribute) class_name() !string {
	return attr.pool.get_class_name(attr.class_index)!
}

fn (attr &EnclosingMethodAttribute) method_name_and_descriptor(mut reader ClassReader) !(string, string) {
	if attr.method_index > 0 {
		return attr.pool.get_name_and_type(attr.method_index)!
	} else {
		return '', ''
	}
}

/*
LineNumberTable_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 line_number_table_length;
    {   u2 start_pc;
        u2 line_number;
    } line_number_table[line_number_table_length];
}
*/
struct LineNumberTableAttribute {
mut:
	line_number_table []LineNumberTableEntry = []LineNumberTableEntry{}
}

fn (mut attr LineNumberTableAttribute) read_info(mut reader ClassReader) ! {
	len := reader.read_u16()
	attr.line_number_table = []LineNumberTableEntry{cap: int(len)}

	for _ in 0 .. len {
		start_pc := reader.read_u16()
		line_number := reader.read_u16()
		attr.line_number_table << LineNumberTableEntry{start_pc, line_number}
	}
}

fn (attr &LineNumberTableAttribute) get_line_number(pc int) int {
	for i := attr.line_number_table.len - 1; i >= 0; i-- {
		entry := attr.line_number_table[i]

		if pc >= entry.start_pc {
			return entry.start_pc
		}
	}
	return -1
}

struct LineNumberTableEntry {
	start_pc    u16
	line_number u16
}

/*
LocalVariableTable_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 local_variable_table_length;
    {   u2 start_pc;
        u2 length;
        u2 name_index;
        u2 descriptor_index;
        u2 index;
    } local_variable_table[local_variable_table_length];
}
*/
struct LocalVariableTableAttribute {
mut:
	local_variable_table []LocalVariableTableEntry = []LocalVariableTableEntry{}
}

fn (mut attr LocalVariableTableAttribute) read_info(mut reader ClassReader) ! {
	len := reader.read_u16()
	attr.local_variable_table = []LocalVariableTableEntry{cap: int(len)}

	for _ in 0 .. len {
		start_pc := reader.read_u16()
		length := reader.read_u16()
		name_index := reader.read_u16()
		descriptor_index := reader.read_u16()
		index := reader.read_u16()
		attr.local_variable_table << LocalVariableTableEntry{start_pc, length, name_index, descriptor_index, index}
	}
}

struct LocalVariableTableEntry {
	start_pc         u16
	length           u16
	name_index       u16
	descriptor_index u16
	index            u16
}

/*
LocalVariableTypeTable_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 local_variable_type_table_length;
    {   u2 start_pc;
        u2 length;
        u2 name_index;
        u2 signature_index;
        u2 index;
    } local_variable_type_table[local_variable_type_table_length];
}
*/
struct LocalVariableTypeTableAttribute {
mut:
	local_variable_type_table []LocalVariableTypeTableEntry = []LocalVariableTypeTableEntry{}
}

fn (mut attr LocalVariableTypeTableAttribute) read_info(mut reader ClassReader) ! {
	len := reader.read_u16()
	attr.local_variable_type_table = []LocalVariableTypeTableEntry{cap: int(len)}

	for _ in 0 .. len {
		start_pc := reader.read_u16()
		length := reader.read_u16()
		name_index := reader.read_u16()
		signature_index := reader.read_u16()
		index := reader.read_u16()
		attr.local_variable_type_table << LocalVariableTypeTableEntry{start_pc, length, name_index, signature_index, index}
	}
}

struct LocalVariableTypeTableEntry {
	start_pc        u16
	length          u16
	name_index      u16
	signature_index u16
	index           u16
}

/*
InnerClasses_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 number_of_classes;
    {   u2 inner_class_info_index;
        u2 outer_class_info_index;
        u2 inner_name_index;
        u2 inner_class_access_flags;
    } classes[number_of_classes];
}
*/
struct InnerClassesAttribute {
mut:
	classes []InnerClassInfo = []InnerClassInfo{}
}

fn (mut attr InnerClassesAttribute) read_info(mut reader ClassReader) ! {
	len := reader.read_u16()
	attr.classes = []InnerClassInfo{cap: int(len)}

	for _ in 0 .. len {
		inner_class_info_index := reader.read_u16()
		outer_class_info_index := reader.read_u16()
		inner_name_index := reader.read_u16()
		inner_class_access_flags := reader.read_u16()
		attr.classes << InnerClassInfo{inner_class_info_index, outer_class_info_index, inner_name_index, inner_class_access_flags}
	}
}

struct InnerClassInfo {
	inner_class_info_index   u16
	outer_class_info_index   u16
	inner_name_index         u16
	inner_class_access_flags u16
}

/*
Exceptions_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 number_of_exceptions;
    u2 exception_index_table[number_of_exceptions];
}
*/
struct ExceptionAttribute {
mut:
	exception_index_table []u16 = []u16{}
}

fn (mut attr ExceptionAttribute) read_info(mut reader ClassReader) ! {
	attr.exception_index_table = reader.read_u16_array()
}

fn (attr &ExceptionAttribute) exception_index_table() []u16 {
	return attr.exception_index_table
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

pub fn (attr &CodeAttribute) max_locals() u16 {
	return attr.max_locals
}

pub fn (attr &CodeAttribute) max_stack() u16 {
	return attr.max_stack
}

pub fn (attr &CodeAttribute) code() []u8 {
	return attr.code
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
Signature_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 signature_index;
}
*/
struct SignatureAttribute {
	pool &ConstantPool [required]
mut:
	signature_index u16
}

fn (mut attr SignatureAttribute) read_info(mut reader ClassReader) ! {
	attr.signature_index = reader.read_u16()
}

fn (attr &SignatureAttribute) signature() !string {
	return attr.pool.get_utf8(attr.signature_index)!
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
