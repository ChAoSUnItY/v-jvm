module extended

import vjvm.instruction.base { BranchInstruction, branch }
import vjvm.rtda { Frame }

pub struct IFNULL {
	BranchInstruction
}

pub fn (mut inst IFNULL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	ref := stack.pop_ref()!
	if isnil(&ref) {
		branch(mut frame, inst.offset)
	}
}

pub struct IFNONNULL {
	BranchInstruction
}

pub fn (mut inst IFNONNULL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	ref := stack.pop_ref()!
	if !isnil(&ref) {
		branch(mut frame, inst.offset)
	}
}
