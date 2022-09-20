module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap { ClassRef }

pub struct INSTANCE_OF {
	Index16Instruction
}

pub fn (mut inst INSTANCE_OF) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	ref := stack.pop_ref()

	if isnil(ref) {
		stack.push_int(0)
		return
	}

	pool := frame.method().class().constant_pool()
	mut class_ref := pool.get_constant(inst.index) or {
		return error('Unable to retrieve class ref from constant pool')
	}

	if mut class_ref is ClassRef {
		class := class_ref.resolve_class()!

		if ref.is_instance_of(class) {
			stack.push_int(1)
		} else {
			stack.push_int(0)
		}
	}
}
