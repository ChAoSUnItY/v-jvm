module load

import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct LLOAD {
	Index8Instruction
}

pub fn (mut inst LLOAD) execute(mut frame Frame) ! {
	lload(mut frame, inst.index)!
}

pub struct LLOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_0) execute(mut frame Frame) ! {
	lload(mut frame, 0)!
}

pub struct LLOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_1) execute(mut frame Frame) ! {
	lload(mut frame, 1)!
}

pub struct LLOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_2) execute(mut frame Frame) ! {
	lload(mut frame, 2)!
}

pub struct LLOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst LLOAD_3) execute(mut frame Frame) ! {
	lload(mut frame, 3)!
}

[inline]
fn lload(mut frame Frame, index u32) {
	val := frame.local_vars().get_i64(index)
	mut stack := frame.operand_stack()
	return stack.push_i64(val)
}
