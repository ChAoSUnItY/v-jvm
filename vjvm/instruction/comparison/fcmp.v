module comparison

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct FCMPG {
	NoOperandInstruction
}

pub fn (mut inst FCMPG) execute(mut frame Frame) ! {
	cmp_g<f32>(mut frame)!
}

pub struct FCMPL {
	NoOperandInstruction
}

pub fn (mut inst FCMPL) execute(mut frame Frame) ! {
	cmp_l<f32>(mut frame)!
}
