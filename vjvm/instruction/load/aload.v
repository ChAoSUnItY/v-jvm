module load

import vjvm.rtda { Frame, Object }
import vjvm.instruction.base { Index8Instruction, NoOperandInstruction }

pub struct ALOAD {
	Index8Instruction
}

pub fn (mut inst ALOAD) execute(mut frame Frame) ! {
	load<Object>(mut frame, inst.index)!
}

pub struct ALOAD_0 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_0) execute(mut frame Frame) ! {
	load<Object>(mut frame, 0)!
}

pub struct ALOAD_1 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_1) execute(mut frame Frame) ! {
	load<Object>(mut frame, 1)!
}

pub struct ALOAD_2 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_2) execute(mut frame Frame) ! {
	load<Object>(mut frame, 2)!
}

pub struct ALOAD_3 {
	NoOperandInstruction
}

pub fn (mut inst ALOAD_3) execute(mut frame Frame) ! {
	load<Object>(mut frame, 3)!
}
