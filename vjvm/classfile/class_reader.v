module classfile

import encoding.binary { big_endian_u16, big_endian_u32, big_endian_u64 }

pub struct ClassReader {
mut:
	bytecode []u8
}

// u1
pub fn (mut reader ClassReader) read_u8() u8 {
	val := reader.bytecode[0]
	reader.drop(1)
	return val
}

// u2
pub fn (mut reader ClassReader) read_u16() u16 {
	val := big_endian_u16(reader.bytecode)
	reader.drop(2)
	return val
}

// u4
pub fn (mut reader ClassReader) read_u32() u32 {
	val := big_endian_u32(reader.bytecode)
	reader.drop(4)
	return val
}

pub fn (mut reader ClassReader) read_u64() u64 {
	val := big_endian_u64(reader.bytecode)
	reader.drop(8)
	return val
}

pub fn (mut reader ClassReader) read_u8_array(len u32) []u8 {
	mut arr := []u8{cap: int(len)}

	for _ in 0 .. len {
		arr << reader.read_u8()
	}

	return arr
}

pub fn (mut reader ClassReader) read_u16_array() []u16 {
	len := reader.read_u16()
	mut arr := []u16{cap: int(len)}

	for _ in 0 .. len {
		arr << reader.read_u16()
	}

	return arr
}

[inline]
fn (mut reader ClassReader) drop(n int) {
	reader.bytecode.drop(n)
}
