module stack

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

// {val} -> {}
pub struct POP {
	NoOperandInstruction
}

pub fn (mut inst POP) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	stack.pop_slot()
}

// {val1, val2} -> {}
pub struct POP2 {
	NoOperandInstruction
}

pub fn (mut inst POP2) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	stack.pop_slot()
	stack.pop_slot()
}
