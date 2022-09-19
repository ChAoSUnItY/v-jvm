module comparison

import vjvm.instruction.base { BranchInstruction, branch }
import vjvm.rtda { Frame }

pub struct IFEQ {
	BranchInstruction
}

pub fn (mut inst IFEQ) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	if stack.pop_int()! == 0 {
		branch(mut frame, inst.offset)
	}
}

pub struct IFNE {
	BranchInstruction
}

pub fn (mut inst IFNE) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	if stack.pop_int()! != 0 {
		branch(mut frame, inst.offset)
	}
}

pub struct IFLT {
	BranchInstruction
}

pub fn (mut inst IFLT) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	if stack.pop_int()! < 0 {
		branch(mut frame, inst.offset)
	}
}

pub struct IFLE {
	BranchInstruction
}

pub fn (mut inst IFLE) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	if stack.pop_int()! <= 0 {
		branch(mut frame, inst.offset)
	}
}

pub struct IFGT {
	BranchInstruction
}

pub fn (mut inst IFGT) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	if stack.pop_int()! > 0 {
		branch(mut frame, inst.offset)
	}
}

pub struct IFGE {
	BranchInstruction
}

pub fn (mut inst IFGE) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	if stack.pop_int()! >= 0 {
		branch(mut frame, inst.offset)
	}
}
