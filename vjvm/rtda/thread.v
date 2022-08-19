module rtda

struct Thread {
mut:
	pc    int
	stack &Stack
}

fn new_thread() Thread {
	return Thread{
		stack: new_stack(1024)
	}
}

pub fn (thread &Thread) pc() int {
	return thread.pc
}

fn (mut thread Thread) set_pc(pc int) {
	thread.pc = pc
}

fn (mut thread Thread) push_frame(mut frame Frame) ! {
	thread.stack.push(mut frame)!
}

fn (mut thread Thread) pop_frame() !&Frame {
	return thread.stack.pop()!
}

fn (thread &Thread) current_frame() !&Frame {
	return thread.stack.peek()!
}
