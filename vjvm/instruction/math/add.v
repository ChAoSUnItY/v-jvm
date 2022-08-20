module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DADD {
	NoOperandInstruction
}

pub fn (mut inst DADD) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<f64>()!
	stack.push<f64>(val1 + val2)
}

pub struct FADD {
	NoOperandInstruction
}

pub fn (mut inst FADD) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<f32>()!
	stack.push<f32>(val1 + val2)
}

pub struct IADD {
	NoOperandInstruction
}

pub fn (mut inst IADD) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<int>()!
	stack.push<int>(val1 + val2)
}

pub struct LADD {
	NoOperandInstruction
}

pub fn (mut inst LADD) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<i64>()!
	stack.push<i64>(val1 + val2)
}
