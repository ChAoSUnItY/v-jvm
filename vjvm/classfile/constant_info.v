module classfile

import math { f32_from_bits, f64_from_bits }

const (
	constant_class               = 7
	constant_fieldref            = 9
	constant_methodref           = 10
	constant_interface_methodref = 11
	constant_string              = 8
	constant_integer             = 3
	constant_float               = 4
	constant_long                = 5
	constant_double              = 6
	constant_name_and_type       = 12
	constant_utf8                = 1
	constant_method_handle       = 15
	constant_method_type         = 16
	constant_invoke_dynamic      = 18
)

/*
cp_info {
    u1 tag;
    u1 info[];
}
*/
interface ConstantInfo {
	read_info(mut ClassReader)
}

fn (mut reader ClassReader) read_constant_info(pool &ConstantPool) ConstantInfo {
	tag := reader.read_u8()
	info := new_constant_info(tag, pool)
	info.read_info(mut reader)
	return info
}

fn new_constant_info(tag u8, pool &ConstantPool) ConstantInfo {
	return match tag {
		classfile.constant_class {
			ConstantClassInfo{pool}
		}
		classfile.constant_fieldref {
			ConstantFieldRefInfo{pool}
		}
		classfile.constant_methodref {
			ConstantMethodRefInfo{pool}
		}
		classfile.constant_interface_methodref {
			ConstantInterfaceRefInfo{pool}
		}
		classfile.constant_string {
			ConstantStringInfo{}
		}
		classfile.constant_integer {
			ConstantIntegerInfo{}
		}
		classfile.constant_float {
			ConstantFloatInfo{}
		}
		classfile.constant_long {
			ConstantFloatInfo{}
		}
		classfile.constant_double {
			ConstantDoubleInfo{}
		}
		classfile.constant_name_and_type {
			ConstantNameAndTypeInfo{pool}
		}
		classfile.constant_utf8 {
			ConstantUtf8Info{}
		}
		classfile.constant_method_handle {
			ConstantMethodHandleInfo{}
		}
		classfile.constant_method_type {
			ConstantMethodTypeInfo{}
		}
		classfile.constant_invoke_dynamic {
			ConstantInvokeDynamicInfo{}
		}
		else {
			panic('java.lang.ClassFormatError: Invalid constant info tag')
		}
	}
}

/*
CONSTANT_Class_info {
    u1 tag;
    u2 name_index;
}
*/
struct ConstantClassInfo {
	pool       &ConstantPool [required]
	name_index u16 = 0
}

fn (mut info ConstantClassInfo) read_info(mut reader ClassReader) {
	info.name_index = reader.read_u16()
}

fn (info &ConstantClassInfo) str() string {
	return info.get_utf8(info.name_index)
}

/*
CONSTANT_MethodHandle_info {
    u1 tag;
    u1 reference_kind;
    u2 reference_index;
}
*/
struct ConstantMethodHandleInfo {
	reference_kind  u8  = 0
	reference_index u16 = 0
}

fn (mut info ConstantMethodHandleInfo) read_info(mut reader ClassReader) {
	info.reference_kind = reader.read_u8()
	info.reference_index = reader.read_u16()
}

/*
CONSTANT_MethodType_info {
    u1 tag;
    u2 descriptor_index;
}
*/
struct ConstantMethodTypeInfo {
	descriptor_index u16 = 0
}

fn (mut info ConstantMethodTypeInfo) read_info(mut reader ClassReader) {
	info.descriptor_index = reader.read_u16()
}

/*
CONSTANT_InvokeDynamic_info {
    u1 tag;
    u2 bootstrap_method_attr_index;
    u2 name_and_type_index;
}
*/
struct ConstantInvokeDynamicInfo {
	bootstrap_method_attr_index u16 = 0
	name_and_type_index         u16 = 0
}

fn (mut info ConstantInvokeDynamicInfo) read_info(mut reader ClassReader) {
	info.bootstrap_method_attr_index = reader.read_u16()
	info.name_and_type_index = reader.read_u16()
}

/*
CONSTANT_Fieldref_info {
    u1 tag;
    u2 class_index;
    u2 name_and_type_index;
}
CONSTANT_Methodref_info {
    u1 tag;
    u2 class_index;
    u2 name_and_type_index;
}
CONSTANT_InterfaceMethodref_info {
    u1 tag;
    u2 class_index;
    u2 name_and_type_index;
}
*/
type ConstantFieldRefInfo = ConstantClassMemberRefInfo
type ConstantMethodRefInfo = ConstantClassMemberRefInfo
type ConstantInterfaceRefInfo = ConstantClassMemberRefInfo

struct ConstantClassMemberRefInfo {
	pool                &ConstantPool [required]
	class_index         u16 = 0
	name_and_type_index u16 = 0
}

fn (mut info ConstantClassMemberRefInfo) read_info(mut reader ClassReader) {
	info.class_index = reader.read_u16()
	info.name_and_type_index = reader.read_u16()
}

fn (info &ConstantClassMemberRefInfo) class_name() string {
	return info.pool.get_class_name(info.class_index)
}

fn (info &ConstantClassMemberRefInfo) name_and_descriptor() (string, string) {
	return info.pool.get_name_and_type(info.name_and_type_index)
}

/*
CONSTANT_NameAndType_info {
    u1 tag;
    u2 name_index;
    u2 descriptor_index;
}
*/
struct ConstantNameAndTypeInfo {
	name_index       u16 = 0
	descriptor_index u16 = 0
}

fn (mut info ConstantNameAndTypeInfo) read_info(mut reader ClassReader) {
	info.name_index = reader.read_u16()
	info.descriptor_index = reader.read_u16()
}

/*
CONSTANT_Integer_info {
    u1 tag;
    u4 bytes;
}
*/
struct ConstantIntegerInfo {
	val int = 0
}

fn (mut info ConstantIntegerInfo) read_info(mut reader ClassReader) {
	info.val = int(reader.read_u32())
}

fn (info &ConstantIntegerInfo) value() int {
	return info.val
}

/*
CONSTANT_Float_info {
    u1 tag;
    u4 bytes;
}
*/
struct ConstantFloatInfo {
	val f32 = 0
}

fn (mut info ConstantFloatInfo) read_info(mut reader ClassReader) {
	info.val = f32_from_bits(reader.read_u32())
}

fn (info &ConstantFloatInfo) value() f32 {
	return info.val
}

/*
CONSTANT_Long_info {
    u1 tag;
    u4 high_bytes;
    u4 low_bytes;
}
*/
struct ConstantLongInfo {
	val i64 = 0
}

fn (mut info ConstantLongInfo) read_info(mut reader ClassReader) {
	info.val = i64(reader.read_u64())
}

fn (info &ConstantLongInfo) value() i64 {
	return info.val
}

/*
CONSTANT_Double_info {
    u1 tag;
    u4 high_bytes;
    u4 low_bytes;
}
*/
struct ConstantDoubleInfo {
	val f64 = 0
}

fn (mut info ConstantDoubleInfo) read_info(mut reader ClassReader) {
	info.val = f64_from_bits(reader.read_u64())
}

fn (info &ConstantDoubleInfo) value() f64 {
	return info.val
}

/*
CONSTANT_String_info {
    u1 tag;
    u2 string_index;
}
*/
type ConstantStringInfo = ConstantUtf8Info

/*
CONSTANT_Utf8_info {
    u1 tag;
    u2 length;
    u1 bytes[length];
}
*/
struct ConstantUtf8Info {
	str string = ''
}

fn (mut info ConstantUtf8Info) read_info(mut reader ClassReader) {
	len := int(reader.read_u16())
	bytes := reader.read_u8_array(len)
	info.str = decode_mutf8(bytes)
}

fn (info &ConstantUtf8Info) str() string {
	return info.str
}

// mutf8 -> utf16 -> utf32 -> string
// see java.io.DataInputStream.readUTF(DataInput)
fn decode_mutf8(segment []byte) ?string {
	utf_len := segment.len

	mut char_arr := []u16{len: utf_len}
	mut c, mut c2, mut c3 := u16(0)
	mut index, mut c_index := 0

	for index < utf_len {
		c = utf16(segment[index])
		if c > 127 {
			break
		}
		index++
		char_arr[c_index] = c
		c_index++
	}

	for index < utf_len {
		c = utf16(segment[index])
		match c >> 4 {
			0...7 {
				index++
				char_arr[c_index] = c
				c_index++
			}
			12...13 {
				index += 2
				if index > utf_len {
					return error('malformed input: index out of bound')
				}
				c2 = segment[index - 1]
				if c2 & 0xC0 != 0x80 {
					return error('malformed input: invlid byte after starting byte')
				}
				char_arr[c_index] = c & 0x1F << 6 | c2 & 0x3F
				c_index++
			}
			14 {
				count += 3
				if index > utf_len {
					return error('malformed input: index out of bound')
				}
				c2 = segment[index - 2]
				c3 = segment[index - 1]
				if c2 & 0xC0 != 0x80 && c3 & 0xC0 != 0x80 {
					return error('malformed input: invlid bytes after starting byte')
				}
				char_arr[c_index] = c & 0x0F << 12 | c2 & 0x3F << 6 | c3 & 0x3F
				c_index++
			}
			else {
				return error('malformed input: invlid starting byte ${segment[index]}')
			}
		}
	}

	char_arr.trim(c_index - 1)
	runes := char_arr.map(rune(it))
	return runes.str()
}
