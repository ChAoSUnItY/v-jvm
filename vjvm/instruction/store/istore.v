module store

import vjvm.rtda { Frame, Object }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct ISTORE {
	Index8Instruction
}

pub fn (mut inst ISTORE) execute(mut frame Frame) ! {
	store<int>(mut frame, inst.index)!
}

pub struct ISTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_0) execute(mut frame Frame) ! {
	store<int>(mut frame, 0)!
}

pub struct ISTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_1) execute(mut frame Frame) ! {
	store<int>(mut frame, 1)!
}

pub struct ISTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_2) execute(mut frame Frame) ! {
	store<int>(mut frame, 2)!
}

pub struct ISTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst ISTORE_3) execute(mut frame Frame) ! {
	store<int>(mut frame, 3)!
}