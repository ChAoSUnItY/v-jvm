module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap { MethodRef }

pub struct INVOKE_VIRTUAL {
	Index16Instruction
}

pub fn (mut inst INVOKE_VIRTUAL) execute(mut frame Frame) ! {
	pool := frame.method().class().constant_pool()
	method_ref := pool.get<MethodRef>(inst.index) or {
		return error('Unable to retrieve method ref from constant pool')
	}

	// FIXME: hack
	if method_ref.name() == 'println' {
		mut stack := frame.operand_stack()

		match method_ref.descriptor() {
			'(Z)V' {
				println('${stack.pop_int() != 0}')
			}
			'(C)V' {
				println('${rune(stack.pop_int())}')
			}
			'(I)V' {
				println('$stack.pop_int()')
			}
			'(F)V' {
				println('$stack.pop_f32()')
			}
			'(J)V' {
				println('$stack.pop_i64()')
			}
			'(D)V' {
				println('$stack.pop_f64()')
			}
			else {
				return error('println: `$method_ref.descriptor()`')
			}
		}

		stack.pop_ref()
	}
}
