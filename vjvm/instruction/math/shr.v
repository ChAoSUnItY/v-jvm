module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct ISHR {
	NoOperandInstruction
}

pub fn (mut inst ISHR) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	stack.push<int>(val1 >> val2)
}

pub struct LSHR {
	NoOperandInstruction
}

pub fn (mut inst LSHR) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<i64>()!
	stack.push<i64>(val1 >> val2)
}
