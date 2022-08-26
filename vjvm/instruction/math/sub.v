module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DSUB {
	NoOperandInstruction
}

pub fn (mut inst DSUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<f64>()!
	stack.push<f64>(val1 - val2)
}

pub struct FSUB {
	NoOperandInstruction
}

pub fn (mut inst FSUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<f32>()!
	stack.push<f32>(val1 - val2)
}

pub struct ISUB {
	NoOperandInstruction
}

pub fn (mut inst ISUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<int>()!
	stack.push<int>(val1 - val2)
}

pub struct LSUB {
	NoOperandInstruction
}

pub fn (mut inst LSUB) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<i64>()!
	stack.push<i64>(val1 - val2)
}
