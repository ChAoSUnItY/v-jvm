module comparison

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DCMPG {
	NoOperandInstruction
}

pub fn (mut inst DCMPG) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f64()
	val1 := stack.pop_f64()
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

pub struct DCMPL {
	NoOperandInstruction
}

pub fn (mut inst DCMPL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_f64()
	val1 := stack.pop_f64()
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
