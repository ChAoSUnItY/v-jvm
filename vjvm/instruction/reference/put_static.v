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
	mut field_ref := pool.get_constant(inst.index) or {
		return error('Unable to retrieve field ref from constant pool')
	}

	if mut field_ref is FieldRef {
		field := field_ref.resolve_field()!
		field_class := field_ref.class()!

		if !field.is_static() {
			return error('java.lang.IncompatibleClassChangeError')
		}

		if field.is_final() && (class != field_class || method.name() != '_clinit') {
			return error('java.lang.IllegalAccessError')
		}

		descriptor := field.descriptor()
		slot_id := field.slot_id()
		slots := field_class.static_vars()
		mut stack := frame.operand_stack()

		match descriptor[0] {
			`Z`, `B`, `C`, `S`, `I` {
				slots.set_int(slot_id, stack.pop_int()!)
			}
			`J` {
				slots.set_i64(slot_id, stack.pop_i64()!)
			}
			`F` {
				slots.set_f32(slot_id, stack.pop_f32()!)
			}
			`D` {
				slots.set_f64(slot_id, stack.pop_f64()!)
			}
			`L`, '[' {
				slots.set_ref(slot_id, stack.pop_ref()!)
			}
			else {
				// TODO
			}
		}
	}
}
