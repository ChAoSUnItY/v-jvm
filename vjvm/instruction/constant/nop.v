module constant

import vjvm.rtda { Frame }
import vjvm.instructions.base

pub struct NOP {
	base.NoOperandInstruction
}

pub fn (mut inst NOP) execute(mut frame Frame) {}
