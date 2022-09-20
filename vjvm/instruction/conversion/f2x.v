module conversion

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct F2D {
	NoOperandInstruction
}

pub fn (mut inst F2D) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_f32()
	stack.push_f64(val)
}

pub struct F2I {
	NoOperandInstruction
}

pub fn (mut inst F2I) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_f32()
	stack.push_int(int(val))
}

pub struct F2L {
	NoOperandInstruction
}

pub fn (mut inst F2L) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_f32()
	stack.push_i64(i64(val))
}
