module store

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct FSTORE {
	Index8Instruction
}

pub fn (mut inst FSTORE) execute(mut frame Frame) ! {
	store<f32>(mut frame, inst.index)!
}

pub struct FSTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_0) execute(mut frame Frame) ! {
	store<f32>(mut frame, 0)!
}

pub struct FSTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_1) execute(mut frame Frame) ! {
	store<f32>(mut frame, 1)!
}

pub struct FSTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_2) execute(mut frame Frame) ! {
	store<f32>(mut frame, 2)!
}

pub struct FSTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst FSTORE_3) execute(mut frame Frame) ! {
	store<f32>(mut frame, 3)!
}
