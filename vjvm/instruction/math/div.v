module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DDIV {
	NoOperandInstruction
}

pub fn (mut inst DDIV) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<f64>()!
	stack.push<f64>(val1 / val2)
}

pub struct FDIV {
	NoOperandInstruction
}

pub fn (mut inst FDIV) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<f32>()!
	stack.push<f32>(val1 / val2)
}

pub struct IDIV {
	NoOperandInstruction
}

pub fn (mut inst IDIV) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<int>()!
	stack.push<int>(val1 / val2)
}

pub struct LDIV {
	NoOperandInstruction
}

pub fn (mut inst LDIV) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<i64>()!
	stack.push<i64>(val1 / val2)
}
