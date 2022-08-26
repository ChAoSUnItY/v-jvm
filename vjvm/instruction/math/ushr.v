module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct IUSHR {
	NoOperandInstruction
}

pub fn (mut inst IUSHR) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	stack.push<int>(val1 >>> val2)
}

pub struct LUSHR {
	NoOperandInstruction
}

pub fn (mut inst LUSHR) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<i64>()!
	stack.push<i64>(val1 >>> val2)
}
