module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap { ClassRef }

pub struct NEW {
	Index16Instruction
}

pub fn (mut inst NEW) execute(mut frame Frame) ! {
	pool := frame.method().class().constant_pool()
	mut class_ref := pool.get_constant(inst.index) or {
		return error('Unable to retrieve class info from constant pool')
	}

	if mut class_ref is ClassRef {
		class := class_ref.resolve_class()!

		if class.is_interface() || class.is_abstract() {
			return error('java.lang.InstantiationError')
		}

		ref := class.new_object()
		mut stack := frame.operand_stack()
		stack.push_ref(ref)
	}
}
