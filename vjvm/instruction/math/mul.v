module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DMUL {
	NoOperandInstruction
}

pub fn (mut inst DMUL) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<f64>(mut stack)!
	stack.push<f64>(val1 * val2)
}

pub struct FMUL {
	NoOperandInstruction
}

pub fn (mut inst FMUL) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<f32>(mut stack)!
	stack.push<f32>(val1 * val2)
}

pub struct IMUL {
	NoOperandInstruction
}

pub fn (mut inst IMUL) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<int>(mut stack)!
	stack.push<int>(val1 * val2)
}

pub struct LMUL {
	NoOperandInstruction
}

pub fn (mut inst LMUL) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<i64>(mut stack)!
	stack.push<i64>(val1 * val2)
}
