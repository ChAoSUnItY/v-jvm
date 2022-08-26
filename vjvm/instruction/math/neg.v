module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DNEG {
	NoOperandInstruction
}

pub fn (mut inst DNEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<f64>()!
	stack.push<f64>(-val)
}

pub struct FNEG {
	NoOperandInstruction
}

pub fn (mut inst FNEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<f32>()!
	stack.push<f32>(-val)
}

pub struct INEG {
	NoOperandInstruction
}

pub fn (mut inst INEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<int>()!
	stack.push<int>(-val)
}

pub struct LNEG {
	NoOperandInstruction
}

pub fn (mut inst LNEG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.pop<i64>()!
	stack.push<i64>(-val)
}
