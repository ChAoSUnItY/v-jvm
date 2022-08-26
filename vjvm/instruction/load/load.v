module load

import vjvm.rtda { Frame }

fn load<T>(mut frame Frame, index u32) ! {
	val := frame.local_vars().get<T>(index)!
	mut stack := frame.operand_stack()
	stack.push<T>(val)
}
