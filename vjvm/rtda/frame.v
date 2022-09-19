module rtda

import vjvm.rtda.heap { Method }

pub struct Frame {
mut:
	local_vars    LocalVars
	opreand_stack &OperandStack
	lower         &Frame
	thread        &Thread
	method        &heap.Method
	next_pc       int
}

pub fn (thread &Thread) new_frame(method &Method) Frame {
	return Frame{
		local_vars: new_local_vars(method.max_locals())
		operand_stack: new_operand_stack(method.max_stack())
		lower: unsafe { nil }
		thread: unsafe { thread }
		method: method
	}
}

pub fn (frame &Frame) local_vars() LocalVars {
	return frame.local_vars
}

pub fn (frame &Frame) operand_stack() &OperandStack {
	return frame.opreand_stack
}

pub fn (frame &Frame) thread() &Thread {
	return frame.thread
}

pub fn (frame &Frame) method() &Method {
	return frame.method
}

pub fn (frame &Frame) next_pc() int {
	return frame.next_pc
}

pub fn (mut frame Frame) set_next_pc(next_pc int) {
	frame.next_pc = next_pc
}
