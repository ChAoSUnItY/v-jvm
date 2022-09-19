module math

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct IAND {
	NoOperandInstruction
}

pub fn (mut inst IAND) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_int()
	val1 := stack.pop_int()
	stack.push_int(val1 & val2)
}

pub struct LAND {
	NoOperandInstruction
}

pub fn (mut inst LAND) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_i64()
	val1 := stack.pop_i64()
	stack.push_i64(val1 & val2)
}
