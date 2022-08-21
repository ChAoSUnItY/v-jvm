module comparison

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct DCMPG {
	NoOperandInstruction
}

pub fn (mut inst DCMPG) execute(mut frame Frame) ! {
	cmp_g<f64>(mut frame)!
}

pub struct DCMPL {
	NoOperandInstruction
}

pub fn (mut inst DCMPL) execute(mut frame Frame) ! {
	cmp_l<f64>(mut frame)!
}
