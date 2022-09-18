module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DDIV {
	NoOperandInstruction
}

pub fn (mut inst DDIV) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f64()
	val1 := stack.pop_f64()
	stack.push_f64(val1 / val2)
}

pub struct FDIV {
	NoOperandInstruction
}

pub fn (mut inst FDIV) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f32()
	val1 := stack.pop_f32()
	stack.push_f32(val1 / val2)
}

pub struct IDIV {
	NoOperandInstruction
}

pub fn (mut inst IDIV) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_int()
	val1 := stack.pop_int()
	stack.push_int(val1 / val2)
}

pub struct LDIV {
	NoOperandInstruction
}

pub fn (mut inst LDIV) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_i64()
	val1 := stack.pop_i64()
	stack.push_i64(val1 / val2)
}
