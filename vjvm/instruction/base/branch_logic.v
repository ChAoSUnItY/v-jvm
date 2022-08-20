module base

import vjvm.rtda { Frame }

pub fn branch(mut frame Frame, offset int) {
	pc := frame.thread().pc()
	next_pc := pc + offset
	frame.set_next_pc(next_pc)
}
