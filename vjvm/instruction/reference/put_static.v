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

	if !field.is_static() {
		return error('java.lang.IncompatibleClassChangeError')
	}

	if field.is_final() && (class != field_class || method.name() != "<clinit>") {
		return error('java.lang.IllegalAccessError')
	}

	descriptor := field.descriptor()
	slot_id := field.slot_id()
	slots := field_class.static_vars()
	mut stack := frame.operand_stack()

	match descriptor[0] {
		'Z', 'B', 'C', 'S', 'I' {
			slots.set<int>(slot_id, stack.pop<int>()!)
		}
		'J' {
			slots.set<i64>(slot_id, stack.pop<i64>()!)
		}
		'F' {
			slots.set<f32>(slot_id, stack.pop<f32>()!)
		}
		'D' {
			slots.set<f64>(slot_id, stack.pop<f64>()!)
		}
		'L', '[' {
			slots.set<Object>(slot_id, stack.pop<Object>()!)
		}
		else {
			// TODO
		}
	}
}
