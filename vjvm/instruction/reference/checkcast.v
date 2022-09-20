module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap { ClassRef }

pub struct CHECK_CAST {
	Index16Instruction
}

pub fn (mut inst CHECK_CAST) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	ref := stack.pop_ref()

	if isnil(ref) {
		return
	}

	pool := frame.method().class().constant_pool()
	mut class_ref := pool.get_constant(inst.index) or {
		return error('Unable to retrieve class ref from constant pool')
	}

	if mut class_ref is ClassRef {
		class := class_ref.resolve_class()!

		if !ref.is_instance_of(class) {
			return error('java.lang.ClassCastException')
		}
	}
}
