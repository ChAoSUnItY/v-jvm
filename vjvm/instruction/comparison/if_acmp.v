module comparison

import vjvm.instruction.base { BranchInstruction, branch }
import vjvm.rtda { Frame }

pub struct IF_ACMPEQ {
	BranchInstruction
}

pub fn (mut inst IF_ACMPEQ) execute(mut frame Frame) ! {
	if acmp(mut frame)! {
		branch(mut frame, inst.offset)
	}
}

pub struct IF_ACMPNE {
	BranchInstruction
}

pub fn (mut inst IF_ACMPNE) execute(mut frame Frame) ! {
	if !acmp(mut frame)! {
		branch(mut frame, inst.offset)
	}
}

[inline]
fn acmp(mut frame Frame) !bool {
	mut stack := frame.operand_stack()
	val2 := stack.pop_ref()
	val1 := stack.pop_ref()
	return charptr(&val1) == charptr(&val2)
}
