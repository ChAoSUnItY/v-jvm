module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct IUSHR {
	NoOperandInstruction
}

pub fn (mut inst IUSHR) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<int>(mut stack)!
	stack.push<int>(val1 >>> val2)
}

pub struct LUSHR {
	NoOperandInstruction
}

pub fn (mut inst LUSHR) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<i64>(mut stack)!
	stack.push<i64>(val1 >>> val2)
}
