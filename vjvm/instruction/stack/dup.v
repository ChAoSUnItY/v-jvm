module stack

import vjvm.rtda { Frame, Slot }
import vjvm.instruction.base { NoOperandInstruction }

// {val} -> {val, val}
pub struct DUP {
	NoOperandInstruction
}

pub fn (mut inst DUP) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val := stack.top()
	stack.push<Slot>(val)
}

// {val1, val2} -> {val2, val1, val2}
pub struct DUP_X1 {
	NoOperandInstruction
}

pub fn (mut inst DUP_X1) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val2 := stack.pop<Slot>()!
	val1 := stack.pop<Slot>()!
	stack.push<Slot>(val2)
	stack.push<Slot>(val1)
	stack.push<Slot>(val2)
}

// {val1, val2, val3} -> {val3, val1, val2, val3}
pub struct DUP_X2 {
	NoOperandInstruction
}

pub fn (mut inst DUP_X2) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val3 := stack.pop<Slot>()!
	val2 := stack.pop<Slot>()!
	val1 := stack.pop<Slot>()!
	stack.push<Slot>(val3)
	stack.push<Slot>(val1)
	stack.push<Slot>(val2)
	stack.push<Slot>(val3)
}

// {val1, val2} -> {val1, val2, val1, val2}
pub struct DUP2 {
	NoOperandInstruction
}

pub fn (mut inst DUP2) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val2 := stack.peek(0)
	val1 := stack.peek(1)
	stack.push<Slot>(val1)
	stack.push<Slot>(val2)
}

// {val1, val2, val3} -> {val2, val3, val1, val2, val3}
pub struct DUP2_X1 {
	NoOperandInstruction
}

pub fn (mut inst DUP2_X1) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val3 := stack.pop<Slot>()!
	val2 := stack.pop<Slot>()!
	val1 := stack.pop<Slot>()!
	stack.push<Slot>(val2)
	stack.push<Slot>(val3)
	stack.push<Slot>(val1)
	stack.push<Slot>(val2)
	stack.push<Slot>(val3)
}

// {val1, val2, val3, val4} -> {val3, val4, val1, val2, val3, val4}
pub struct DUP2_X2 {
	NoOperandInstruction
}

pub fn (mut inst DUP2_X2) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val4 := stack.pop<Slot>()!
	val3 := stack.pop<Slot>()!
	val2 := stack.pop<Slot>()!
	val1 := stack.pop<Slot>()!
	stack.push<Slot>(val3)
	stack.push<Slot>(val4)
	stack.push<Slot>(val1)
	stack.push<Slot>(val2)
	stack.push<Slot>(val3)
	stack.push<Slot>(val4)
}
