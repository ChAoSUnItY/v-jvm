module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap { FieldRef }

pub struct PUT_FIELD {
	Index16Instruction
}

pub fn (mut inst PUT_FIELD) execute(mut frame Frame) ! {
	method := frame.method()
	class := method.class()
	pool := class.constant_pool()
	mut field_ref := pool.get_constant(inst.index) or {
		return error('Unable to retrieve field ref from constant pool')
	}

	if mut field_ref is FieldRef {
		field := field_ref.resolve_field()!
		field_class := field_ref.class()!

		if field.is_static() {
			return error('java.lang.IncompatibleClassChangeError')
		}

		if field.is_final() && (class != field_class || method.name() != '<init>') {
			return error('java.lang.IllegalAccessError')
		}

		descriptor := field.descriptor()
		slot_id := field.slot_id()
		mut stack := frame.operand_stack()
		mut fields := ref.fields()

		match descriptor[0] {
			`Z`, `B`, `C`, `S`, `I` {
				val := stack.pop_int()
				ref := stack.pop_ref()

				if isnil(ref) {
					return error('java.lang.NullPointerException')
				}

				fields.set_int(slot_id, val)
			}
			`J` {
				val := stack.pop_i64()
				ref := stack.pop_ref()

				if isnil(ref) {
					return error('java.lang.NullPointerException')
				}

				fields.set_i64(slot_id, val)
			}
			`F` {
				val := stack.pop_f32()
				ref := stack.pop_ref()

				if isnil(ref) {
					return error('java.lang.NullPointerException')
				}

				fields.set_f32(slot_id, val)
			}
			`D` {
				val := stack.pop_f64()
				ref := stack.pop_ref()

				if isnil(ref) {
					return error('java.lang.NullPointerException')
				}

				fields.set_f64(slot_id, val)
			}
			`L`, '[' {
				val := stack.pop_ref()
				ref := stack.pop_ref()

				if isnil(ref) {
					return error('java.lang.NullPointerException')
				}

				fields.set_ref(slot_id, val)
			}
			else {
				// TODO
			}
		}
	}
}
