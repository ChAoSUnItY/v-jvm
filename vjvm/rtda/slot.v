module rtda

import vjvm.rtda.heap { Object }

pub struct Slot {
mut:
	num int
	ref &heap.Object = unsafe { nil }
}
