module load

import vjvm.rtda { Frame }
import vjvm.instruction.load { Index8Instruction, NoOperandInstruction }

pub struct FLOAD {
	Index8Instruction
}

pub fn (mut inst FLOAD) execute(mut frame Frame) ! {
	fload(mut frame, inst.index)!
}

pub struct FLOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_0) execute(mut frame Frame) ! {
	fload(mut frame, 0)
}

pub struct FLOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_1) execute(mut frame Frame) ! {
	fload(mut frame, 1)
}

pub struct FLOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_2) execute(mut frame Frame) ! {
	fload(mut frame, 2)
}

pub struct FLOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst FLOAD_3) execute(mut frame Frame) ! {
	fload(mut frame, 3)
}

fn fload(mut frame Frame, index u32) ! {
	val := frame.local_vars().get<f32>(index)!
	mut stack := frame.opreand_stack()
	stack.push<f32>(val)
}
