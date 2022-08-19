module rtda

[heap]
pub struct Frame {
mut:
	local_vars    LocalVars
	opreand_stack &OperandStack
	lower         &Frame
}

fn new_frame(max_locals u32, max_stack u32) &Frame {
	return &Frame{
		lower: unsafe { nil }
		local_vars: new_local_vars(max_locals)
		opreand_stack: new_operand_stack(max_stack)
	}
}

pub fn (frame &Frame) local_vars() LocalVars {
	return frame.local_vars
}

pub fn (frame &Frame) opreand_stack() &OperandStack {
	return frame.opreand_stack
}
