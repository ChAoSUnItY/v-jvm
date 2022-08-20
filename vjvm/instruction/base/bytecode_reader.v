module base

struct BytecodeReader {
mut:
	bytecode []u8
	pc       int
}

pub fn (mut reader BytecodeReader) reset(bytecode []u8, pc int) {
	reader.bytecode = bytecode
	reader.pc = pc
}

pub fn (mut reader BytecodeReader) read_u8() u8 {
	i := reader.bytecode[reader.pc]
	reader.pc++
	return i
}

pub fn (mut reader BytecodeReader) read_i8() i8 {
	return i8(reader.read_u8())
}

pub fn (mut reader BytecodeReader) read_u16() u16 {
	b1 := u16(reader.read_u8())
	b2 := u16(reader.read_u8())
	return (b1 << 8) | b2
}

pub fn (mut reader BytecodeReader) read_i16() i16 {
	return i16(reader.read_u16())
}

pub fn (mut reader BytecodeReader) read_int() int {
	b1 := int(reader.read_u8())
	b2 := int(reader.read_u8())
	b3 := int(reader.read_u8())
	b4 := int(reader.read_u8())
	return (b1 << 24) | (b2 << 16) | (b3 << 8) | b4
}

pub fn (mut reader BytecodeReader) read_int_arr(len int) []int {
	mut arr := []int{cap: len}

	for _ in 0 .. len {
		arr << reader.read_int()
	}

	return arr
}

pub fn (mut reader BytecodeReader) skip_padding() {
	for reader.pc % 4 != 0 {
		reader.pc++
	}
}

pub fn (reader &BytecodeReader) pc() int {
	return reader.pc
}
