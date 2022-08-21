module comparison

import vjvm.rtda { Frame }
import vjvm.instruction.base { NoOperandInstruction }

pub struct LCMP {
	NoOperandInstruction
}

pub fn (mut inst LCMP) execute(mut frame Frame) ! {
	cmp_g<i64>(mut frame)! // g flag does not effect i64's comparison
}
