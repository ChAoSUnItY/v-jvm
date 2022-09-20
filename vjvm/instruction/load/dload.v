module load

import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct DLOAD {
	Index8Instruction
}

pub fn (mut inst DLOAD) execute(mut frame Frame) ! {
	dload(mut frame, inst.index)
}

pub struct DLOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_0) execute(mut frame Frame) ! {
	dload(mut frame, 0)
}

pub struct DLOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_1) execute(mut frame Frame) ! {
	dload(mut frame, 1)
}

pub struct DLOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_2) execute(mut frame Frame) ! {
	dload(mut frame, 2)
}

pub struct DLOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst DLOAD_3) execute(mut frame Frame) ! {
	dload(mut frame, 3)
}

[inline]
fn dload(mut frame Frame, index u32) {
	val := frame.local_vars().get_f64(index)
	mut stack := frame.operand_stack()
	stack.push_f64(val)
}
