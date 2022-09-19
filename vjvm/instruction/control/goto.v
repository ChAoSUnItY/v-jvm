module control

import vjvm.instruction.base { BranchInstruction, branch }
import vjvm.rtda { Frame }

pub struct GOTO {
	BranchInstruction
}

pub fn (mut inst GOTO) execute(mut frame Frame) ! {
	branch(mut frame, inst.offset)
}
