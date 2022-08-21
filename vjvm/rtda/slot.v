module rtda

import math { f32_from_bits, f64_from_bits }

pub struct Slot {
mut:
	num int
	ref &Object
}

[inline]
fn (slot &Slot) conv<T>() !T {
	$if T is Object {
		return *slot.ref
	} $else $if T is int {
		return slot.num
	} $else $if T is f32 {
		return f32_from_bits(u32(slot.conv<int>()!))
	} $else $if T is Slot {
		return slot
	} $else {
		return error('$T.name is not a valid slot item')
	}
}

[inline]
fn (slot1 &Slot) conv2<T>(slot2 &Slot) !T {
	$if T is i64 {
		return i64(slot1.num) << 32 | i64(slot2.num)
	} $else $if T is f64 {
		return f64_from_bits(u64(slot1.conv2<i64>(slot2)!))
	} $else {
		return error('$T.name is not a valid slot item')
	}
}
