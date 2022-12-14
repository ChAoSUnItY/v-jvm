module load

import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct FLOAD {
	Index8Instruction
}

pub fn (mut inst FLOAD) execute(mut frame Frame) ! {
	fload(mut frame, inst.index)
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

[inline]
fn fload(mut frame Frame, index u32) {
	val := frame.local_vars().get_f32(index)
	mut stack := frame.operand_stack()
	stack.push_f32(val)
}
