module stack

import vjvm.instruction.base { NoOperandInstruction }
import vjvm.rtda { Frame }

// {val} -> {val, val}
pub struct DUP {
	NoOperandInstruction
}

pub fn (mut inst DUP) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val := stack.top()
	stack.push_slot(val)
}

// {val1, val2} -> {val2, val1, val2}
pub struct DUP_X1 {
	NoOperandInstruction
}

pub fn (mut inst DUP_X1) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.pop_slot()
	val1 := stack.pop_slot()
	stack.push_slot(val2)
	stack.push_slot(val1)
	stack.push_slot(val2)
}

// {val1, val2, val3} -> {val3, val1, val2, val3}
pub struct DUP_X2 {
	NoOperandInstruction
}

pub fn (mut inst DUP_X2) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val3 := stack.pop_slot()
	val2 := stack.pop_slot()
	val1 := stack.pop_slot()
	stack.push_slot(val3)
	stack.push_slot(val1)
	stack.push_slot(val2)
	stack.push_slot(val3)
}

// {val1, val2} -> {val1, val2, val1, val2}
pub struct DUP2 {
	NoOperandInstruction
}

pub fn (mut inst DUP2) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val2 := stack.peek(0)
	val1 := stack.peek(1)
	stack.push_slot(val1)
	stack.push_slot(val2)
}

// {val1, val2, val3} -> {val2, val3, val1, val2, val3}
pub struct DUP2_X1 {
	NoOperandInstruction
}

pub fn (mut inst DUP2_X1) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val3 := stack.pop_slot()
	val2 := stack.pop_slot()
	val1 := stack.pop_slot()
	stack.push_slot(val2)
	stack.push_slot(val3)
	stack.push_slot(val1)
	stack.push_slot(val2)
	stack.push_slot(val3)
}

// {val1, val2, val3, val4} -> {val3, val4, val1, val2, val3, val4}
pub struct DUP2_X2 {
	NoOperandInstruction
}

pub fn (mut inst DUP2_X2) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	val4 := stack.pop_slot()
	val3 := stack.pop_slot()
	val2 := stack.pop_slot()
	val1 := stack.pop_slot()
	stack.push_slot(val3)
	stack.push_slot(val4)
	stack.push_slot(val1)
	stack.push_slot(val2)
	stack.push_slot(val3)
	stack.push_slot(val4)
}
