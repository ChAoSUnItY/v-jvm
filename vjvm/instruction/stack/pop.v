module stack

import vjvm.rtda { Frame, Slot }
import vjvm.instruction.base { NoOperandInstruction }

// {val} -> {}
pub struct POP {
	NoOperandInstruction
}

pub fn (mut inst POP) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	stack.pop<Slot>()!
}

// {val1, val2} -> {}
pub struct POP2 {
	NoOperandInstruction
}

pub fn (mut inst POP2) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	stack.pop<Slot>()!
	stack.pop<Slot>()!
}
