module math

import vjvm.rtda { OperandStack }

fn pop2<T>(mut stack OperandStack) !(T, T) {
	val1 := stack.pop<T>()!
	val2 := stack.pop<T>()!
	return val2, val1
}
