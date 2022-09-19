module load

import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct ILOAD {
	Index8Instruction
}

pub fn (mut inst ILOAD) execute(mut frame Frame) ! {
	iload(mut frame, inst.index)!
}

pub struct ILOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_0) execute(mut frame Frame) ! {
	iload(mut frame, 0)!
}

pub struct ILOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_1) execute(mut frame Frame) ! {
	iload(mut frame, 1)!
}

pub struct ILOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_2) execute(mut frame Frame) ! {
	iload(mut frame, 2)!
}

pub struct ILOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst ILOAD_3) execute(mut frame Frame) ! {
	iload(mut frame, 3)!
}

[inline]
fn iload(mut frame Frame, index u32) {
	val := frame.local_vars().get_int(index)
	mut stack := frame.operand_stack()
	return stack.push_int(val)
}
