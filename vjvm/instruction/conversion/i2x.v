module conversion

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct I2B {
	NoOperandInstruction
}

pub fn (mut inst I2B) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<int>()!
	stack.push<int>(i8(val))
}

pub struct I2C {
	NoOperandInstruction
}

pub fn (mut inst I2C) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<int>()!
	stack.push<int>(u16(val))
}

pub struct I2S {
	NoOperandInstruction
}

pub fn (mut inst I2S) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<int>()!
	stack.push<int>(i16(val))
}

pub struct I2F {
	NoOperandInstruction
}

pub fn (mut inst I2F) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<int>()!
	stack.push<f32>(val)
}

pub struct I2D {
	NoOperandInstruction
}

pub fn (mut inst I2D) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<int>()!
	stack.push<f64>(val)
}

pub struct I2L {
	NoOperandInstruction
}

pub fn (mut inst I2L) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<int>()!
	stack.push<i64>(val)
}
