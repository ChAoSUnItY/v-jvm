module constant

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct NOP {
	NoOperandInstruction
}

pub fn (mut inst NOP) execute(mut frame Frame) ! {}
