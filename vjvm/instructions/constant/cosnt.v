module constant

import vjvm.rtda { Frame }
import vjvm.instructions.base { NoOperandInstruction }

pub struct ACONST_NULL {
	NoOperandInstruction
}

pub fn (mut inst ACONST_NULL) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push_nil()
}

pub struct DCONST_0 {
	NoOperandInstruction
}

pub fn (mut inst DCONST_0) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<f64>(0)
}

pub struct DCONST_1 {
	NoOperandInstruction
}

pub fn (mut inst DCONST_1) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<f64>(1)
}

pub struct FCONST_0 {
	NoOperandInstruction
}

pub fn (mut inst FCONST_0) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<f32>(0)
}

pub struct FCONST_1 {
	NoOperandInstruction
}

pub fn (mut inst FCONST_1) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<f32>(1)
}
