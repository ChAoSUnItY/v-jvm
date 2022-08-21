module conversion

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct L2F {
	NoOperandInstruction
}

pub fn (mut inst L2F) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val := stack.pop<i64>()!
	stack.push<f32>(f32(val))
}

pub struct L2D {
	NoOperandInstruction
}

pub fn (mut inst L2D) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val := stack.pop<i64>()!
	stack.push<f64>(val)
}

pub struct L2I {
	NoOperandInstruction
}

pub fn (mut inst L2I) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val := stack.pop<i64>()!
	stack.push<int>(int(val))
}
