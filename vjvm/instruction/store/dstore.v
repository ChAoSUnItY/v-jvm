module store

import vjvm.rtda { Frame, Object }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct DSTORE {
	Index8Instruction
}

pub fn (mut inst DSTORE) execute(mut frame Frame) ! {
	store<f64>(mut frame, inst.index)!
}

pub struct DSTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_0) execute(mut frame Frame) ! {
	store<f64>(mut frame, 0)!
}

pub struct DSTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_1) execute(mut frame Frame) ! {
	store<f64>(mut frame, 1)!
}

pub struct DSTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_2) execute(mut frame Frame) ! {
	store<f64>(mut frame, 2)!
}

pub struct DSTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst DSTORE_3) execute(mut frame Frame) ! {
	store<f64>(mut frame, 3)!
}