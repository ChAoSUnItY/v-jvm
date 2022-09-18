module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DSUB {
	NoOperandInstruction
}

pub fn (mut inst DSUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f64()
	val1 := stack.pop_f64()
	stack.push_f64(val1 - val2)
}

pub struct FSUB {
	NoOperandInstruction
}

pub fn (mut inst FSUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f32()
	val1 := stack.pop_f32()
	stack.push_f32(val1 - val2)
}

pub struct ISUB {
	NoOperandInstruction
}

pub fn (mut inst ISUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_int()
	val1 := stack.pop_int()
	stack.push_int(val1 - val2)
}

pub struct LSUB {
	NoOperandInstruction
}

pub fn (mut inst LSUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_i64()
	val1 := stack.pop_i64()
	stack.push_i64(val1 - val2)
}
