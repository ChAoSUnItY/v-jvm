module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DADD {
	NoOperandInstruction
}

pub fn (mut inst DADD) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f64()
	val1 := stack.pop_f64()
	stack.push_f64(val1 + val2)
}

pub struct FADD {
	NoOperandInstruction
}

pub fn (mut inst FADD) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f32()
	val1 := stack.pop_f32()
	stack.push_f32(val1 + val2)
}

pub struct IADD {
	NoOperandInstruction
}

pub fn (mut inst IADD) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_int()
	val1 := stack.pop_int()
	stack.push_int(val1 + val2)
}

pub struct LADD {
	NoOperandInstruction
}

pub fn (mut inst LADD) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_i64()
	val1 := stack.pop_i64()
	stack.push_i64(val1 + val2)
}
