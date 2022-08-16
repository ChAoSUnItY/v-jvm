module classfile

import encoding.binary { big_endian_u16, big_endian_u32, big_endian_u64 }

pub struct ClassReader {
mut:
	bytecode []u8
}

// u1
pub fn (classfile ClassFile) read_u8() u8 {
	val := class_data.bytecode[0]
	classfile.drop(1)
	return val
}

// u2
pub fn (mut classfile ClassFile) read_u16() u16 {
	val := big_endian_u16(classfile.bytecode)
	classfile.drop(2)
	return val
}

// u4
pub fn (mut classfile ClassFile) read_u32() u32 {
	val := big_endian_u32(classfile.bytecode)
	classfile.drop(4)
	return val
}

pub fn (mut classfile ClassFile) read_u64() u64 {
	val := big_endian_u64(classfile.bytecode)
	classfile.drop(8)
	return val
}

pub fn (mut classfile ClassFile) read_u8_array() []u8 {
	len := classfile.read_u8()
	arr := []u16{len: int(len)}

	for _ in 0 .. len {
		arr << classfile.read_u8()
	}

	return arr
}

pub fn (mut classfile ClassFile) read_u16_array() []u16 {
	len := classfile.read_u16()
	arr := []u16{len: int(len)}

	for _ in 0 .. len {
		arr << classfile.read_u16()
	}

	return arr
}

[inline]
fn (mut classfile ClassFile) drop(n int) {
	classfile.bytecode.drop(n)
}
