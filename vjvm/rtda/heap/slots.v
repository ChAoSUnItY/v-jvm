module heap

import math { f32_bits, f32_from_bits, f64_bits, f64_from_bits }

type Slots = []Slot

pub struct Slot {
mut:
	num int
	ref &Object = unsafe { nil }
}

fn new_slots(count int) &Slots {
	return if count > 0 {
		&[]Slot{len: count, init: Slot{}}
	} else {
		unsafe { nil }
	}
}

[inline]
pub fn (mut slots Slots) set_int(index u32, val int) {
	slots[index].num = val
}

[inline]
pub fn (mut slots Slots) set_f32(index u32, val f32) {
	slots[index].num = int(f32_bits(val))
}

[inline]
pub fn (mut slots Slots) set_i64(index u32, val i64) {
	slots[index].num = int(val)
	slots[index + 1].num = int(val >> 32)
}

[inline]
pub fn (mut slots Slots) set_f64(index u32, val f64) {
	slots.set_i64(index, i64(f64_bits(val)))
}

[inline]
pub fn (mut slots Slots) set_ref(index u32, val &Object) {
	slots[index].ref = unsafe { val }
}

[inline]
pub fn (slots Slots) get_int(index u32) int {
	return slots[index].num
}

[inline]
pub fn (slots Slots) get_f32(index u32) f32 {
	return f32_from_bits(u32(slots[index].num))
}

[inline]
pub fn (slots Slots) get_i64(index u32) i64 {
	low := slots[index].num
	high := slots[index - 1].num
	return i64(high) << 32 | i64(low)
}

[inline]
pub fn (slots Slots) get_f64(index u32) f64 {
	return f64_from_bits(u64(slots.get_i64(index)))
}

[inline]
pub fn (slots Slots) get_ref(index u32) &Object {
	return slots[index].ref
}
