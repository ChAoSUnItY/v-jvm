module store

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct ISTORE {
	Index8Instruction
}

pub fn (mut inst ISTORE) execute(mut frame Frame) ! {
	istore(mut frame, inst.index)!
}

pub struct ISTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_0) execute(mut frame Frame) ! {
	istore(mut frame, 0)!
}

pub struct ISTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_1) execute(mut frame Frame) ! {
	istore(mut frame, 1)!
}

pub struct ISTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_2) execute(mut frame Frame) ! {
	istore(mut frame, 2)!
}

pub struct ISTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_3) execute(mut frame Frame) ! {
	istore(mut frame, 3)!
}

fn istore(mut frame Frame, index u32) {
	mut stack := frame.operand_stack()
	val := stack.pop_int()
	mut locals := frame.local_vars()
	locals.set_int(val, index)
}
