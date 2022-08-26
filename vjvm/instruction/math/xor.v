module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct IXOR {
	NoOperandInstruction
}

pub fn (mut inst IXOR) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	stack.push<int>(val1 ^ val2)
}

pub struct LXOR {
	NoOperandInstruction
}

pub fn (mut inst LXOR) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<i64>()!
	stack.push<i64>(val1 ^ val2)
}
