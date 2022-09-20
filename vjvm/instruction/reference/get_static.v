module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap { FieldRef }

pub struct GET_STATIC {
	Index16Instruction
}

pub fn (mut inst GET_STATIC) execute(mut frame Frame) ! {
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

		descriptor := field.descriptor()
		slots := field_class.static_vars()
		mut stack := frame.operand_stack()

		match descriptor[0] {
			`Z`, `B`, `C`, `S`, `I` {
				stack.push_int(slots.get_int()!)
			}
			`J` {
				stack.push_i64(slots.get_i64()!)
			}
			`F` {
				stack.push_f32(slots.get_f32()!)
			}
			`D` {
				stack.push_f64(slots.get_f64()!)
			}
			`L`, '[' {
				stack.push_ref(slots.get_ref()!)
			}
			else {
				// TODO
			}
		}
	}
}
