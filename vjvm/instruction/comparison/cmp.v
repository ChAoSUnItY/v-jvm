module comparison

import vjvm.rtda { Frame, Object }

[inline]
fn acmp(mut frame Frame) !bool {
	mut stack := frame.operand_stack()
	val1, val2 := stack.pop2<Object>()!
	return charptr(&val1) == charptr(&val2)
}
