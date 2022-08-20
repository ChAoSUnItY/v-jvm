module rtda

pub struct Frame {
mut:
	local_vars    LocalVars
	opreand_stack &OperandStack
	lower         &Frame
	thread        &Thread
	next_pc       int
}

fn new_frame(thread &Thread, max_locals u32, max_stack u32) &Frame {
	return &Frame{
		local_vars: new_local_vars(max_locals)
		opreand_stack: new_operand_stack(max_stack)
		lower: unsafe { nil }
		thread: unsafe { thread }
	}
}

pub fn (frame &Frame) local_vars() LocalVars {
	return frame.local_vars
}

pub fn (frame &Frame) opreand_stack() &OperandStack {
	return frame.opreand_stack
}

pub fn (frame &Frame) thread() &Thread {
	return frame.thread
}

pub fn (frame &Frame) next_pc() int {
	return frame.next_pc
}

pub fn (mut frame Frame) set_next_pc(next_pc int) {
	frame.next_pc = next_pc
}
