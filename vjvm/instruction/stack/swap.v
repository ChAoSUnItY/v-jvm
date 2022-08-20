module stack

import vjvm.rtda { Frame, Slot }
import vjvm.instruction.base { NoOperandInstruction }

// {val1, val2} -> {val2, val1}
pub struct SWAP {
	NoOperandInstruction
}

pub fn (mut inst SWAP) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val2 := stack.pop<Slot>()!
	val1 := stack.pop<Slot>()!
	stack.push<Slot>(val2)
	stack.push<Slot>(val1)
}
