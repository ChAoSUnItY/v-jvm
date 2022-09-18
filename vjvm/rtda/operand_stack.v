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

[inline]
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

[inline]
pub fn (mut stack OperandStack) push_nil() {
	stack.slots[stack.size].ref = unsafe { nil }
	stack.size++
}

[inline]
pub fn (mut stack OperandStack) pop_int() int {
	stack.size--
	return stack.slots[stack.size].num
}

[inline]
pub fn (mut stack OperandStack) pop_f32() f32 {
	stack.size--
	return f32_from_bits(u32(stack.pop_int()))
}

[inline]
pub fn (mut stack OperandStack) pop_i64() i64 {
	low := stack.slots[stack.size - 1].num
	high := stack.slots[stack.size - 2].num
	stack.size -= 2
	return i64(high) << 32 | i64(low)
}

[inline]
pub fn (mut stack OperandStack) pop_f64() f64 {
	return f64_from_bits(u64(stack.i64()!))
}

[inline]
pub fn (mut stack OperandStack) pop_slot() Slot {
	stack.size--
	return stack.slots[stack.size]
}

[inline]
pub fn (mut stack OperandStack) pop_ref() &Object {
	stack.size--
	return stack.slots[stak.size].ref
}

[inline]
pub fn (stack &OperandStack) top() Slot {
	return stack.peek(0)
}

[inline]
pub fn (stack &OperandStack) peek(offset u32) Slot {
	return stack.slots[stack.size - offset - 1]
}
