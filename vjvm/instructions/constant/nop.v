module constant

import vjvm.rtda { Frame }
import vjvm.instructions.base

struct NOP {
	base.NoOperandInstruction
}

fn (mut inst NOP) execute(mut frame Frame) {}
