module store

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct DSTORE {
	Index8Instruction
}

pub fn (mut inst DSTORE) execute(mut frame Frame) ! {
	dstore(mut frame, inst.index)!
}

pub struct DSTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_0) execute(mut frame Frame) ! {
	dstore(mut frame, 0)!
}

pub struct DSTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_1) execute(mut frame Frame) ! {
	dstore(mut frame, 1)!
}

pub struct DSTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_2) execute(mut frame Frame) ! {
	dstore(mut frame, 2)!
}

pub struct DSTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_3) execute(mut frame Frame) ! {
	dstore(mut frame, 3)!
}

fn dstore(mut frame Frame, index u32) {
	mut stack := frame.operand_stack()
	val := stack.pop_f64()
	mut locals := frame.local_vars()
	locals.set_d64(val, index)
}
