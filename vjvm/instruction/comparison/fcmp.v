module comparison

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct FCMPG {
	NoOperandInstruction
}

pub fn (mut inst FCMPG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f32()
	val1 := stack.pop_f32()
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

pub struct FCMPL {
	NoOperandInstruction
}

pub fn (mut inst FCMPL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f32()
	val1 := stack.pop_f32()
	val := if val1 > val2 {
		1
	} else if val1 == val2 {
		0
	} else if val1 < val2 {
		-1
	} else {
		-1
	}
	stack.push_int(val)
}
