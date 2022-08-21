module math

import math { mod }
import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DREM {
	NoOperandInstruction
}

pub fn (mut inst DREM) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<f64>(mut stack)!
	stack.push<f64>(mod(val1, val2))
}

pub struct FREM {
	NoOperandInstruction
}

pub fn (mut inst FREM) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<f32>(mut stack)!
	stack.push<f32>(f32(mod(val1, val2)))
}

pub struct IREM {
	NoOperandInstruction
}

pub fn (mut inst IREM) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<int>(mut stack)!
	stack.push<int>(val1 % val2)
}

pub struct LREM {
	NoOperandInstruction
}

pub fn (mut inst LREM) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := pop2<i64>(mut stack)!
	stack.push<i64>(val1 % val2)
}
