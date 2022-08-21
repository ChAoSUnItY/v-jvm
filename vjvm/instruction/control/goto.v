module control

import vjvm.rtda { Frame }
import vjvm.instruction.base { BranchInstruction, branch }

pub struct GOTO {
	BranchInstruction
}

pub fn (mut inst GOTO) execute(mut frame Frame) ! {
	branch(mut frame, inst.offset)
}
