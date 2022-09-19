module rtda

import math { f32_bits, f32_from_bits, f64_bits, f64_from_bits }

type LocalVars = []Slot

fn new_local_vars(max_locals u32) ?LocalVars {
	return []Slot{len:int(max_locals), init: Slot{}}
}

[inline]
pub fn (mut local LocalVars) set_int(val int, index u32) {
	local.slots[index].num = val
}

[inline]
pub fn (mut local LocalVars) set_f32(val f32, index u32) {
	local.slots[index].num = int(f32_bits(val))
}

[inline]
pub fn (mut local LocalVars) set_i64(val i64, index u32) {
	local.slots[index].num = int(val)
	local.slots[index + 1].num = int(val >> 32)
}

[inline]
pub fn (mut local LocalVars) set_f64(val f64, index u32) {
	bits := i64(f32_bits(val))
	local.set_i64(bits, index)
}

[inline]
pub fn (mut local LocalVars) set_ref(val &Object, index u32) {
	local.slots[index].ref = val
}

[inline]
pub fn (local &LocalVars) get_int(index u32) int {
	return local.slots[index].num
}

[inline]
pub fn (local &LocalVars) get_f32(index u32) f32 {
	return f32_from_bits(u32(local.slots[index].num))
}

[inline]
pub fn (local &LocalVars) get_i64(index u32) i64 {
	low := local.slots[index].num
	high := local.slots[index - 1].num
	return i64(high) << 32 | i64(low)
}

[inline]
pub fn (local &LocalVars) get_f64(index u32) f64 {
	return f64_from_bits(u64(local.get_i64(index)))
}

[inline]
pub fn (local &LocalVars) get_ref(index u32) &Object {
	return local.slots[index].ref
}
