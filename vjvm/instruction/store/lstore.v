module store

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct LSTORE {
	Index8Instruction
}

pub fn (mut inst LSTORE) execute(mut frame Frame) ! {
	store<i64>(mut frame, inst.index)!
}

pub struct LSTORE_0 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_0) execute(mut frame Frame) ! {
	store<i64>(mut frame, 0)!
}

pub struct LSTORE_1 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_1) execute(mut frame Frame) ! {
	store<i64>(mut frame, 1)!
}

pub struct LSTORE_2 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_2) execute(mut frame Frame) ! {
	store<i64>(mut frame, 2)!
}

pub struct LSTORE_3 {
	NoOperandInstruction
}

pub fn (mut inst LSTORE_3) execute(mut frame Frame) ! {
	store<i64>(mut frame, 3)!
}
