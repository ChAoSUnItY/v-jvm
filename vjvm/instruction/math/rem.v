module math

import math { mod }
import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct DREM {
	NoOperandInstruction
}

pub fn (mut inst DREM) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f64()
	val1 := stack.pop_f64()
	stack.push_f64(mod(val1, val2))
}

pub struct FREM {
	NoOperandInstruction
}

pub fn (mut inst FREM) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f32()
	val1 := stack.pop_f32()
	stack.push_f32(f32(mod(val1, val2)))
}

pub struct IREM {
	NoOperandInstruction
}

pub fn (mut inst IREM) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_int()
	val1 := stack.pop_int()
	stack.push_int(val1 % val2)
}

pub struct LREM {
	NoOperandInstruction
}

pub fn (mut inst LREM) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_i64()
	val1 := stack.pop_i64()
	stack.push_i64(val1 % val2)
}
