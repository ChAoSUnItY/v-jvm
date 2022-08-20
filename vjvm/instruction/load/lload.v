module load

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct LLOAD {
	Index8Instruction
}

pub fn (mut inst LLOAD) execute(mut frame Frame) ! {
	load<i64>(mut frame, inst.index)!
}

pub struct LLOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_0) execute(mut frame Frame) ! {
	load<i64>(mut frame, 0)!
}

pub struct LLOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_1) execute(mut frame Frame) ! {
	load<i64>(mut frame, 1)!
}

pub struct LLOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_2) execute(mut frame Frame) ! {
	load<i64>(mut frame, 2)!
}

pub struct LLOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_3) execute(mut frame Frame) ! {
	load<i64>(mut frame, 3)!
}
