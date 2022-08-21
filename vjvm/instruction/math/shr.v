module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct ISHR {
	NoOperandInstruction
}

pub fn (mut inst ISHR) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<int>(mut stack)!
	stack.push<int>(val1 >> val2)
}

pub struct LSHR {
	NoOperandInstruction
}

pub fn (mut inst LSHR) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<i64>(mut stack)!
	stack.push<i64>(val1 >> val2)
}