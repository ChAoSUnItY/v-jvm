module store

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct FSTORE {
	Index8Instruction
}

pub fn (mut inst FSTORE) execute(mut frame Frame) ! {
	fstore(mut frame, inst.index)
}

pub struct FSTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_0) execute(mut frame Frame) ! {
	fstore(mut frame, 0)
}

pub struct FSTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_1) execute(mut frame Frame) ! {
	fstore(mut frame, 1)
}

pub struct FSTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_2) execute(mut frame Frame) ! {
	fstore(mut frame, 2)
}

pub struct FSTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_3) execute(mut frame Frame) ! {
	fstore(mut frame, 3)
}

fn fstore(mut frame Frame, index u32) {
	mut stack := frame.operand_stack()
	val := stack.pop_f32()
	mut locals := frame.local_vars()
	locals.set_f32(val, index)
}
