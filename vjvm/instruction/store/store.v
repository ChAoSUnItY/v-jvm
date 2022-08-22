module store

import vjvm.rtda { Frame }

fn store<T>(mut frame Frame, index u32) ! {
	mut stack := frame.opreand_stack()
	val := stack.pop<T>()!
	mut locals := frame.local_vars()
	locals.set<T>(val, index)
}
