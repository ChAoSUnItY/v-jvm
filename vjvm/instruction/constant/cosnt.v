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

pub struct FCONST_2 {
	NoOperandInstruction
}

pub fn (mut inst FCONST_2) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<f32>(2)
}

pub struct ICONST_M1 {
	NoOperandInstruction
}

pub fn (mut inst ICONST_M1) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<int>(-1)
}

pub struct ICONST_0 {
	NoOperandInstruction
}

pub fn (mut inst ICONST_0) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<int>(0)
}

pub struct ICONST_1 {
	NoOperandInstruction
}

pub fn (mut inst ICONST_1) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<int>(1)
}

pub struct ICONST_2 {
	NoOperandInstruction
}

pub fn (mut inst ICONST_2) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<int>(2)
}

pub struct ICONST_3 {
	NoOperandInstruction
}

pub fn (mut inst ICONST_3) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<int>(3)
}

pub struct ICONST_4 {
	NoOperandInstruction
}

pub fn (mut inst ICONST_4) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<int>(4)
}

pub struct ICONST_5 {
	NoOperandInstruction
}

pub fn (mut inst ICONST_5) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<int>(5)
}

pub struct LCONST_0 {
	NoOperandInstruction
}

pub fn (mut inst LCONST_0) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<i64>(0)
}

pub struct LCONST_1 {
	NoOperandInstruction
}

pub fn (mut inst LCONST_1) execute(mut frame Frame) {
	mut stack := frame.opreand_stack()
	stack.push<i64>(1)
}
