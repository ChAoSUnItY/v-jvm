module stack

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame, Slot }

// {val1, val2} -> {val2, val1}
pub struct SWAP {
	NoOperandInstruction
}

pub fn (mut inst SWAP) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_slot()
	val1 := stack.pop_slot()
	stack.push_slot(val2)
	stack.push_slot(val1)
}
