module constant

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct NOP {
	NoOperandInstruction
}

pub fn (mut inst NOP) execute(mut frame Frame) ! {}
