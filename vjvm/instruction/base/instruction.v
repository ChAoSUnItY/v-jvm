module base

import vjvm.rtda { Frame }

pub interface Instruction {
mut:
	fetch_operands(mut BytecodeReader)
	execute(mut Frame) !
}

pub struct NoOperandInstruction {}

pub fn (mut inst NoOperandInstruction) fetch_operands(mut reader BytecodeReader) {}

pub struct BranchInstruction {
pub mut:
	offset int
}

pub fn (mut inst BranchInstruction) fetch_operands(mut reader BytecodeReader) {
	inst.offset = reader.read_i16()
}

pub struct Index8Instruction {
pub mut:
	index u32
}

pub fn (mut inst Index8Instruction) fetch_operands(mut reader BytecodeReader) {
	inst.index = reader.read_u8()
}

pub struct Index16Instruction {
pub mut:
	index u16
}

pub fn (mut inst Index16Instruction) fetch_operands(mut reader BytecodeReader) {
	inst.index = reader.read_u16()
}

pub struct UninitializedInstruction {}

pub fn (mut inst UninitializedInstruction) fetch_operands(mut reader BytecodeReader) {}

pub fn (mut ints UninitializedInstruction) execute(mut frame Frame) ! {}
