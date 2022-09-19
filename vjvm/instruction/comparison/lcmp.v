module comparison

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

pub struct LCMP {
	NoOperandInstruction
}

pub fn (mut inst LCMP) execute(mut frame Frame) ! {
	// g flag does not effect i64's comparison
	mut stack := frame.operand_stack()
	val2 := stack.pop_i64()
	val1 := stack.pop_i64()
	val := if val1 > val2 {
		1
	} else if val1 == val2 {
		0
	} else if val1 < val2 {
		-1
	} else {
		1
	}
	stack.push_int(val)
}
