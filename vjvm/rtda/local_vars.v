module rtda

import math { f32_bits, f64_bits, f64_bits, f64_from_bits }

struct LocalVars {
mut:
	slots []&Slot
}

fn new_local_vars(max_locals u32) &LocalVars {
	return if max_locals > 0 {
		&LocalVars{unsafe { []&Slot{len: int(max_locals), init: nil} }}
	} else {
		unsafe { nil }
	}
}

pub fn (mut local LocalVars) set<T>(val T, index int) {
	$if T is Object {
		local.slots[index].ref = &val
	} $else $if T is int {
		local.slots[index].num = val
	} $else $if T is f32 {
		local.slots[index].num = int(f32_bits(val))
	} $else $if T is i64 {
		local.slots[index].num = int(val)
		local.slots[index + 1].num = int(val >> 32)
	} $else $if T is f32 {
		bits := i64(f32_bits(val))
		local.set(bits)
	} $else $if T is f64 {
		bits := i64(f64_bits(val))
		local.set(bits)
	}
}

pub fn (local LocalVars) get<T>(index int) !T {
	return $if T is Object {
		local.slots[index].ref
	} $else $if T is int {
		local.slots[index].num
	} $else $if T is f32 {
		f32_from_bits(u32(local.slots[index].num))
	} $else $if T is i64 {
		low := local.slots[index].num
		high := local.slots[index - 1].num
		i64(high) << 32 | i64(low)
	} $else $if T is f32 {
		f32_from_bits(u32(local.slots[index].num))
	} $else $if T is f64 {
		f64_from_bits(u64(local.get<i64>(index)))
	} $else {
		error('$T.name is not a valid Slot item')
	}
}
