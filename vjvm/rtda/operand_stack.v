module rtda

import math { f32_bits, f32_from_bits, f64_bits, f64_from_bits }
import datatypes { Stack }

struct OperandStack {
	max_size u32
mut:
	slots &Stack<Slot>
}

fn new_operand_stack(max_size u32) &OperandStack {
	if max_size > 0 {
		return &OperandStack{max_size, &Stack<Slot>{[]Slot{}}}
	} else {
		return unsafe { nil }
	}
}

fn (mut stack OperandStack) push_int(val int) ! {
	stack.push(new_num_slot(val))!
}

fn (mut stack OperandStack) pop_int() !int {
	val := stack.pop()!
	return val.num
}

fn (mut stack OperandStack) push_float(val f32) ! {
	bits := int(f32_bits(val))
	stack.push(new_num_slot(bits))!
}

fn (mut stack OperandStack) pop_float() !f32 {
	bits := stack.pop()!
	return f32_from_bits(u32(bits.num))
}

// long consumes 2 slots
fn (mut stack OperandStack) push_long(val i64) ! {
	stack.push(new_num_slot(int(val)))!
	stack.push(new_num_slot(int(val >> 32)))!
}

fn (mut stack OperandStack) pop_long() !i64 {
	low := stack.pop()!.num
	high := stack.pop()!.num
	return i64(high) << 32 | i64(low)
}

// double consumes 2 slots
fn (mut stack OperandStack) push_double(val f64) ! {
	bits := i64(f64_bits(val))
	stack.push_long(bits)!
}

fn (mut stack OperandStack) pop_double() !f64 {
	bits := u64(stack.pop()!.num)
	return f64_from_bits(bits)
}

fn (mut stack OperandStack) push_ref(ref &Object) ! {
	stack.push(new_obj_slot(ref))!
}

fn (mut stack OperandStack) pop_ref() &Object {
	return stack.pop()!.ref
}

// util functions
fn (mut stack OperandStack) pop() !Slot {
	return stack.slots.pop() or { err }
}

fn (mut stack OperandStack) push(slot Slot) ! {
	stack.slots.push(slot)
	stack.check_size()!
}

fn (stack &OperandStack) check_size() ! {
	if stack.slots.len() > stack.max_size {
		return error('Operand stack overflow')
	}
}
