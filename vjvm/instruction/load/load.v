module load

import vjvm.rtda { Frame }

fn load<T>(mut frame Frame, index u32) ! {
	val := frame.local_vars().get<T>(int(index))!
	mut stack := frame.opreand_stack()
	stack.push<T>(val)
}
