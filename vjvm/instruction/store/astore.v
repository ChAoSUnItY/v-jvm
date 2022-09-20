module store

import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct ASTORE {
	Index8Instruction
}

pub fn (mut inst ASTORE) execute(mut frame Frame) ! {
	astore(mut frame, inst.index)
}

pub struct ASTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_0) execute(mut frame Frame) ! {
	astore(mut frame, 0)
}

pub struct ASTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_1) execute(mut frame Frame) ! {
	astore(mut frame, 1)
}

pub struct ASTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_2) execute(mut frame Frame) ! {
	astore(mut frame, 2)
}

pub struct ASTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_3) execute(mut frame Frame) ! {
	astore(mut frame, 3)
}

fn astore(mut frame Frame, index u32) {
	mut stack := frame.operand_stack()
	val := stack.pop_ref()
	mut locals := frame.local_vars()
	locals.set_ref(val, index)
}
