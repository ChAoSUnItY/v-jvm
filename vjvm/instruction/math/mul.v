module math

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct DMUL {
	NoOperandInstruction
}

pub fn (mut inst DMUL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f64()
	val1 := stack.pop_f64()
	stack.push_f64(val1 * val2)
}

pub struct FMUL {
	NoOperandInstruction
}

pub fn (mut inst FMUL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f32()
	val1 := stack.pop_f32()
	stack.push_f32(val1 * val2)
}

pub struct IMUL {
	NoOperandInstruction
}

pub fn (mut inst IMUL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_int()
	val1 := stack.pop_int()
	stack.push_int(val1 * val2)
}

pub struct LMUL {
	NoOperandInstruction
}

pub fn (mut inst LMUL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_i64()
	val1 := stack.pop_i64()
	stack.push_i64(val1 * val2)
}
