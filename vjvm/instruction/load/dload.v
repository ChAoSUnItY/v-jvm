module load

import vjvm.rtda { Frame }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct DLOAD {
	Index8Instruction
}

pub fn (mut inst DLOAD) execute(mut frame Frame) ! {
	load<f64>(mut frame, inst.index)!
}

pub struct DLOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_0) execute(mut frame Frame) ! {
	load<f64>(mut frame, 0)!
}

pub struct DLOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_1) execute(mut frame Frame) ! {
	load<f64>(mut frame, 1)!
}

pub struct DLOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_2) execute(mut frame Frame) ! {
	load<f64>(mut frame, 2)!
}

pub struct DLOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_3) execute(mut frame Frame) ! {
	load<f64>(mut frame, 3)!
}
