module extended

import vjvm.rtda { Frame, Object }
import vjvm.instruction.base { BranchInstruction, branch }

pub struct IFNULL {
	BranchInstruction
}

pub fn (mut inst IFNULL) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	ref := stack.pop<Object>()!
	if isnil(&ref) {
		branch(mut frame, inst.offset)
	}
}

pub struct IFNONNULL {
	BranchInstruction
}

pub fn (mut inst IFNONNULL) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	ref := stack.pop<Object>()!
	if !isnil(&ref) {
		branch(mut frame, inst.offset)
	}
}
