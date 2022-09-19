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
	field_ref := pool.get<FieldRef>(inst.index) or {
		return error('Unable to retrieve field ref from constant pool')
	}
	field := field_ref.resolve_field()!
	field_class := field_ref.class()!

	if !field.is_static() {
		return error('java.lang.IncompatibleClassChangeError')
	}

	descriptor := field.descriptor()
	slot_id := field.slot_id()
	slots := field_class.static_vars()
	mut stack := frame.operand_stack()

	match descriptor[0] {
		'Z', 'B', 'C', 'S', 'I' {
			stack.push<int>(slots.get<int>()!)
		}
		'J' {
			stack.push<i64>(slots.get<i64>()!)
		}
		'F' {
			stack.push<f32>(slots.get<f32>()!)
		}
		'D' {
			stack.push<f64>(slots.get<f64>()!)
		}
		'L', '[' {
			stack.push<Object>(slots.get<Object>()!)
		}
		else {
			// TODO
		}
	}
}
