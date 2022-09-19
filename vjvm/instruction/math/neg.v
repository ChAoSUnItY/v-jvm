module math

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct DNEG {
	NoOperandInstruction
}

pub fn (mut inst DNEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_f64()!
	stack.push_f64(-val)
}

pub struct FNEG {
	NoOperandInstruction
}

pub fn (mut inst FNEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_f32()!
	stack.push_f32(-val)
}

pub struct INEG {
	NoOperandInstruction
}

pub fn (mut inst INEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_int()!
	stack.push_int(-val)
}

pub struct LNEG {
	NoOperandInstruction
}

pub fn (mut inst LNEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop_i64()!
	stack.push_i64(-val)
}
