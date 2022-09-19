module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap { FieldRef }

pub struct PUT_STATIC {
	Index16Instruction
}

pub fn (mut inst PUT_STATIC) execute(mut frame Frame) ! {
	method := frame.method()
	class := method.class()
	pool := class.constant_pool()
	field_ref := pool.get<FieldRef>(inst.index) or {
		return error('Unable to retrieve field ref from constant pool')
	}
	field := field_ref.resolve_field()!
	field_class := field_ref.class()!

	if field.is_static() {
		return error('java.lang.IncompatibleClassChangeError')
	}

	descriptor := field.descriptor()
	mut slots := ref.fields()
	slot_id := field.slot_id()
	mut stack := frame.operand_stack()
	ref := stack.pop_ref()

	if isnil(ref) {
		return error('java.lang.NullPointerException')
	}

	match descriptor[0] {
		'Z', 'B', 'C', 'S', 'I' {
			stack.push_int(slots.get_int(slot_id))
		}
		'J' {
			stack.push_i64(slots.get_i64(slot_id))
		}
		'F' {
			stack.push_f32(slots.get_f32(slot_id))
		}
		'D' {
			stack.push_f64(slots.get_f64(slot_id))
		}
		'L', '[' {
			stack.push_ref(slots.get_ref(slot_id))
		}
		else {
			// TODO
		}
	}
}
