module rtda

pub struct Thread {
mut:
	pc    int
	stack &Stack
}

pub fn new_thread() Thread {
	return Thread{
		stack: new_stack(1024)
	}
}

pub fn (thread &Thread) pc() int {
	return thread.pc
}

pub fn (mut thread Thread) set_pc(pc int) {
	thread.pc = pc
}

pub fn (mut thread Thread) push_frame(mut frame Frame) ! {
	thread.stack.push(mut frame)!
}

pub fn (mut thread Thread) pop_frame() !&Frame {
	return thread.stack.pop()!
}

pub fn (thread &Thread) current_frame() !&Frame {
	return thread.stack.peek()!
}
