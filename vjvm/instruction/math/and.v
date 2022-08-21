module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct IAND {
	NoOperandInstruction
}

pub fn (mut inst IAND) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<int>()!
	stack.push<int>(val1 & val2)
}

pub struct LAND {
	NoOperandInstruction
}

pub fn (mut inst LAND) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<i64>()!
	stack.push<i64>(val1 & val2)
}
