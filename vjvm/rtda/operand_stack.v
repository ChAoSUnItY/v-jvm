module rtda

import math { f32_bits, f32_from_bits, f64_bits, f64_from_bits }

struct OperandStack {
mut:
	size  u32
	slots []Slot
}

fn new_operand_stack(max_size u32) &OperandStack {
	return if max_size > 0 {
		&OperandStack{0, []Slot{len: int(max_size), init: Slot{0, unsafe { nil }}}}
	} else {
		unsafe { nil }
	}
}

pub fn (mut stack OperandStack) push<T>(val T) {
	$if T is Object {
		stack.slots[stack.size].ref = &val
		stack.size++
	} $else $if T is int {
		stack.slots[stack.size].num = val
		stack.size++
	} $else $if T is f32 {
		stack.slots[stack.size].num = int(f32_bits(val))
		stack.size++
	} $else $if T is i64 {
		stack.slots[stack.size].num = int(val)
		stack.slots[stack.size + 1].num = int(i64(val) >> 32)
		stack.size += 2
	} $else $if T is f32 {
		bits := i64(f32_bits(val))
		stack.push(bits)
	} $else $if T is f64 {
		bits := i64(f64_bits(val))
		stack.push(bits)
	} $else $if T is Slot {
		stack.slots[stack.size] = val
		stack.size++
	}
}

pub fn (mut stack OperandStack) push_nil() {
	stack.slots[stack.size].ref = unsafe { nil }
	stack.size++
}

pub fn (mut stack OperandStack) pop<T>() !T {
	$if T is Object {
		stack.size--
		return *stack.slots[stack.size].ref
	} $else $if T is int {
		stack.size--
		return stack.slots[stack.size].num
	} $else $if T is f32 {
		stack.size--
		return f32_from_bits(u32(stack.slots[stack.size].num))
	} $else $if T is i64 {
		low := stack.slots[stack.size].num
		high := stack.slots[stack.size - 1].num
		stack.size -= 2
		return i64(high) << 32 | i64(low)
	} $else $if T is f32 {
		stack.size--
		val := stack.slots[stack.size].num
		return f32_from_bits(u32(val))
	} $else $if T is f64 {
		low := stack.slots[stack.size].num
		high := stack.slots[stack.size - 1].num
		val := i64(high) << 32 | i64(low)
		stack.size -= 2
		return f64_from_bits(u64(val))
	} $else $if T is Slot {
		stack.size--
		return stack.slots[stack.size]
	} $else {
		return error('$T.name is not a valid slot item')
	}
}
