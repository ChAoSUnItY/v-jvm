module comparison

import vjvm.rtda { Frame, Object }

fn cmp_g<T>(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<T>()!
	val := if val1 > val2 {
		1
	} else if val1 == val2 {
		0
	} else if val1 < val2 {
		-1
	} else {
		1
	}
	stack.push<int>(val)
}

fn cmp_l<T>(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<T>()!
	val := if val1 > val2 {
		1
	} else if val1 == val2 {
		0
	} else if val1 < val2 {
		-1
	} else {
		-1
	}
	stack.push<int>(val)
}

[inline]
fn acmp(mut frame Frame) !bool {
	mut stack := frame.opreand_stack()
	val1, val2 := stack.pop2<Object>()!
	return charptr(val1) == charptr(val2)
}
