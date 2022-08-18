module rtda

import datatypes { Stack }

struct Thread {
mut:
	pc    int
	stack &Stack<&Frame>
}

fn new_thread() Thread {
	return Thread{
		stack: &Stack<Frame>{[]&Frame{len: 1024}}
	}
}

fn (thread &Thread) pc() int {
	return thread.pc
}

fn (mut thread Thread) set_pc(pc int) {
	thread.pc = pc
}

fn (mut thread Thread) push_frame(frame &Frame) {
	thread.stack.push(frame) or { unsafe { nil } }
}

fn (mut thread Thread) pop_frame() &Frame {
	return thread.stack.pop() or { unsafe { nil } }
}

fn (thread &Thread) current_frame() &Frame {
	return thread.stack.peek() or { unsafe { nil } }
}
