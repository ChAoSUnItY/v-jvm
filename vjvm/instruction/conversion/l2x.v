module conversion

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct L2F {
	NoOperandInstruction
}

pub fn (mut inst L2F) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_i64()
	stack.push_f32(f32(val))
}

pub struct L2D {
	NoOperandInstruction
}

pub fn (mut inst L2D) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_i64()
	stack.push_f64(val)
}

pub struct L2I {
	NoOperandInstruction
}

pub fn (mut inst L2I) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_i64()
	stack.push_int(int(val))
}
