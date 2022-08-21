module comparison

import vjvm.rtda { Frame }
import vjvm.instruction.base { BranchInstruction, branch }

pub struct IF_ACMPEQ {
	BranchInstruction
}

pub fn (mut inst IF_ACMPEQ) execute(mut frame Frame) ! {
	if acmp(mut frame) {
		branch(mut frame, inst.offset)
	}
}

pub struct IF_ACMPEQ {
	BranchInstruction
}

pub fn (mut inst IF_ACMPEQ) execute(mut frame Frame) ! {
	if !acmp(mut frame) {
		branch(mut frame, inst.offset)
	}
}
