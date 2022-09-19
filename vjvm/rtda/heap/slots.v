module heap

import math { f32_from_bits, f64_bits }

type Slots = []Slot

pub struct Slot {
mut:
	num int
	ref &Object = unsafe { nil }
}

fn new_slots(count int) ?Slots {
	return if count > 0 {
		[]Slot{len: count, init: Slot{}}
	} else {
		none
	}
}

[inline]
pub fn (mut slots Slots) set_int(val int, index u32) {
	slots[index].num = val
}

[inline]
pub fn (mut slots Slots) set_f32(val f32, index u32) {
	slots[index].num = int(f32_bits(val))
}

[inline]
pub fn (mut slots Slots) set_i64(val i64, index u32) {
	slots[index].num = int(val)
	slots[index + 1].num = int(val >> 32)
}

[inline]
pub fn (mut slots Slots) set_f64(val f64, index u32) {
	slots.set_i64(index, f64_bits(val))
	slots[index].num = int(f32_bits(val))
}

[inline]
pub fn (mut slots Slots) set_ref(ref &Object, index u32) {
	slots[index].ref = val
}

[inline]
pub fn (slots &Slots) get_int(index u32) int {
	return slots[index].num
}

[inline]
pub fn (slots &Slots) get_f32(index u32) f32 {
	return f32_from_bits(u32(local.slots[index].num))
}

[inline]
pub fn (slots &Slots) get_i64(index u32) i64 {
	low := slots[index].num
	high := slots[index - 1].num
	return i64(high) << 32 | i64(low)
}

[inline]
pub fn (slots &Slots) get_f64(index u32) f64 {
	return f64_from_bits(u64(get<i64>(index)!))
}

[inline]
pub fn (slots &Slots) get_ref(index u32) &Object {
	return slots[index].ref
}
