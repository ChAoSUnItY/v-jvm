module constant

import vjvm.rtda { Frame }
import vjvm.instructions.base { NoOperandInstruction }

struct ACONST_NULL {
	NoOperandInstruction
}

fn (mut inst ACONST_NULL) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push_nil()
}

struct DCONST_0 {
	NoOperandInstruction
}

fn (mut inst DCONST_0) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<f64>(0)
}
