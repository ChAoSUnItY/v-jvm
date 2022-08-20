module load

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct ILOAD {
	Index8Instruction
}

pub fn (mut inst ILOAD) execute(mut frame Frame) ! {
	load<int>(mut frame, inst.index)!
}

pub struct ILOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_0) execute(mut frame Frame) ! {
	load<int>(mut frame, 0)!
}

pub struct ILOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_1) execute(mut frame Frame) ! {
	load<int>(mut frame, 1)!
}

pub struct ILOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_2) execute(mut frame Frame) ! {
	load<int>(mut frame, 2)!
}

pub struct ILOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_3) execute(mut frame Frame) ! {
	load<int>(mut frame, 3)!
}
