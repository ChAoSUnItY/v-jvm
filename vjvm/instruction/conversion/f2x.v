module conversion

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct F2D {
	NoOperandInstruction
}

pub fn (mut inst F2D) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val := stack.pop<f32>()!
	stack.push<f64>(val)
}

pub struct F2I {
	NoOperandInstruction
}

pub fn (mut inst F2I) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val := stack.pop<f32>()!
	stack.push<int>(int(val))
}

pub struct F2L {
	NoOperandInstruction
}

pub fn (mut inst F2L) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val := stack.pop<f32>()!
	stack.push<i64>(i64(val))
}
