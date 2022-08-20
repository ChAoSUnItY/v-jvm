module load

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct FLOAD {
	Index8Instruction
}

pub fn (mut inst FLOAD) execute(mut frame Frame) ! {
	load<f32>(mut frame, inst.index)!
}

pub struct FLOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_0) execute(mut frame Frame) ! {
	load<f32>(mut frame, 0)!
}

pub struct FLOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_1) execute(mut frame Frame) ! {
	load<f32>(mut frame, 1)!
}

pub struct FLOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_2) execute(mut frame Frame) ! {
	load<f32>(mut frame, 2)!
}

pub struct FLOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_3) execute(mut frame Frame) ! {
	load<f32>(mut frame, 3)!
}
