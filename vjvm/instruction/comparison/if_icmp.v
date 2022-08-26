module comparison

import vjvm.rtda { Frame }
import vjvm.instruction.base { BranchInstruction, branch }

pub struct IF_ICMPEQ {
	BranchInstruction
}

pub fn (mut inst IF_ICMPEQ) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	if val1 == val2 {
		branch(mut frame, inst.offset)
	}
}

pub struct IF_ICMPNE {
	BranchInstruction
}

pub fn (mut inst IF_ICMPNE) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	if val1 != val2 {
		branch(mut frame, inst.offset)
	}
}

pub struct IF_ICMPLT {
	BranchInstruction
}

pub fn (mut inst IF_ICMPLT) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	if val1 < val2 {
		branch(mut frame, inst.offset)
	}
}

pub struct IF_ICMPLE {
	BranchInstruction
}

pub fn (mut inst IF_ICMPLE) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	if val1 <= val2 {
		branch(mut frame, inst.offset)
	}
}

pub struct IF_ICMPGT {
	BranchInstruction
}

pub fn (mut inst IF_ICMPGT) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	if val1 > val2 {
		branch(mut frame, inst.offset)
	}
}

pub struct IF_ICMPGE {
	BranchInstruction
}

pub fn (mut inst IF_ICMPGE) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	if val1 >= val2 {
		branch(mut frame, inst.offset)
	}
}
