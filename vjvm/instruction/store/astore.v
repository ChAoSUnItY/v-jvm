module store

import vjvm.rtda { Frame, Object }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct ASTORE {
	Index8Instruction
}

pub fn (mut inst ASTORE) execute(mut frame Frame) ! {
	store<Object>(mut frame, inst.index)!
}

pub struct ASTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_0) execute(mut frame Frame) ! {
	store<Object>(mut frame, 0)!
}

pub struct ASTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_1) execute(mut frame Frame) ! {
	store<Object>(mut frame, 1)!
}

pub struct ASTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_2) execute(mut frame Frame) ! {
	store<Object>(mut frame, 2)!
}

pub struct ASTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst ASTORE_3) execute(mut frame Frame) ! {
	store<Object>(mut frame, 3)!
}
