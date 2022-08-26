module conversion

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct D2F {
	NoOperandInstruction
}

pub fn (mut inst D2F) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<f64>()!
	stack.push<f32>(f32(val))
}

pub struct D2I {
	NoOperandInstruction
}

pub fn (mut inst D2I) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<f64>()!
	stack.push<int>(int(val))
}

pub struct D2L {
	NoOperandInstruction
}

pub fn (mut inst D2L) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<f64>()!
	stack.push<i64>(i64(val))
}
