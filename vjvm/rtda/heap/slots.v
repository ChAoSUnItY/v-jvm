module heap

import math { f32_from_bits, f64_from_bitsf32_bits, f64_bits }

type Slots = []Slot

pub struct Slot {
mut:
	num int
	ref &Object = unsafe { nil }
}

fn new_slots(count int) ?Slots {
	return if count > 0 {
		[]Slot{len:count, init: Slot{}}
	} else {
		none
	}
}

[inline]
fn (mut slots Slots) set<T>(index u32, val T) {
	$if T is int {
		slots[index].num = val
	} $else $if T is f32 {
		slots[index].num = int(f32_bits(val))
	} $else $if T is i64 {
		slots[index].num = int(val)
		slots[index + 1].num = int(val >> 32)
	} $else $if T is f64 {
		slots.set<i64>(index, f64_bits(val))
	} $else $if T is Object {
		slots[index].ref = &val
	}
}

[inline]
fn (mut slots Slots) get<T>(index u32) !T {
	$if T is Object {
		return *slots[index].ref
	} $else $if T is int {
		return slots[index].num
	} $else $if T is f32 {
		return f32_from_bits(u32(local.slots[index].num))
	} $else $if T is i64 {
		low := slots[index].num
		high := slots[index - 1].num
		return i64(high) << 32 | i64(low)
	} $else $if T is f32 {
		return f32_from_bits(u32(slots[index].num))
	} $else $if T is f64 {
		return f64_from_bits(u64(get<i64>(index)!))
	} $else {
		return error('$T.name is not a valid Slot item')
	}
}
