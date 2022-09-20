module store

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct LSTORE {
	Index8Instruction
}

pub fn (mut inst LSTORE) execute(mut frame Frame) ! {
	lstore(mut frame, inst.index)
}

pub struct LSTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_0) execute(mut frame Frame) ! {
	lstore(mut frame, 0)
}

pub struct LSTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_1) execute(mut frame Frame) ! {
	lstore(mut frame, 1)
}

pub struct LSTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_2) execute(mut frame Frame) ! {
	lstore(mut frame, 2)
}

pub struct LSTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_3) execute(mut frame Frame) ! {
	lstore(mut frame, 3)
}

fn lstore(mut frame Frame, index u32) {
	mut stack := frame.operand_stack()
	val := stack.pop_i64()
	mut locals := frame.local_vars()
	locals.set_i64(val, index)
}
