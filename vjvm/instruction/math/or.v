module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct IOR {
	NoOperandInstruction
}

pub fn (mut inst IOR) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<int>(mut stack)!
	stack.push<int>(val1 | val2)
}

pub struct LOR {
	NoOperandInstruction
}

pub fn (mut inst LOR) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<i64>(mut stack)!
	stack.push<i64>(val1 | val2)
}
