module rtda

// Low-level stack implementation
// based on linked list
struct Stack {
	max_size u32
mut:
	size u32
	top  &Frame
}

fn new_stack(max_size u32) &Stack {
	return if max_size > 0 {
		&Stack{max_size, 0, unsafe { nil }}
	} else {
		unsafe { nil }
	}
}

fn (mut stack Stack) push(mut frame Frame) ! {
	if stack.size >= stack.max_size {
		return error('java.lang.StackOverflowError')
	}

	if !isnil(stack.top) {
		frame.lower = stack.top
	}

	stack.top = unsafe { frame }
	stack.size++
}

fn (mut stack Stack) pop() !&Frame {
	if isnil(stack.top) {
		return error('JVM stack is empty')
	}

	mut top := stack.top
	stack.top = top.lower
	top.lower = unsafe { nil }
	stack.size--

	return top
}

fn (stack &Stack) peek() !&Frame {
	if isnil(stack.top) {
		return error('JVM stack is empty')
	}

	return stack.top
}
