module load

import vjvm.rtda { Frame }
import vjvm.instruction.load { Index8Instruction, NoOperandInstruction }

pub struct ALOAD {
	Index8Instruction
}

pub fn (mut inst ALOAD) execute(mut frame Frame) ! {
	aload(mut frame, inst.index)!
}

pub struct ALOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_0) execute(mut frame Frame) ! {
	aload(mut frame, 0)
}

pub struct ALOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_1) execute(mut frame Frame) ! {
	aload(mut frame, 1)
}

pub struct ALOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_2) execute(mut frame Frame) ! {
	aload(mut frame, 2)
}

pub struct ALOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_3) execute(mut frame Frame) ! {
	aload(mut frame, 3)
}

fn aload(mut frame Frame, index u32) ! {
	val := frame.local_vars().get<Object>(index)!
	mut stack := frame.opreand_stack()
	stack.push<Object>(val)
}
