module rtda

import math { f32_from_bits, f64_from_bits }
import heap { Object }

pub struct Slot {
mut:
	num int
	ref &Object = unsafe { nil }
}
