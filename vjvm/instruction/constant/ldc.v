module constant

import vjvm.instruction.base { Index16Instruction, Index8Instruction }
import vjvm.rtda { Frame }
import vjvm.rtda.heap

pub struct LDC {
	Index8Instruction
}

pub fn (mut inst LDC) execute(mut frame Frame) ! {
	ldc(mut frame, inst.index)!
}

pub struct LDC_W {
	Index16Instruction
}

pub fn (mut inst LDC_W) execute(mut frame Frame) ! {
	ldc(mut frame, inst.index)!
}

pub struct LDC2_W {
	Index16Instruction
}

pub fn (mut inst LDC2_W) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	pool := frame.method().class().constant_pool()
	constant := pool.get_constant() or {
		return error('Unable to retrieve constant from constant pool')
	}

	match constant {
		i64 {
			stack.push_i64(constant)
		}
		f64 {
			stack.push_f64(constant)
		}
		else {
			return error('java.lang.ClassFormatError')
		}
	}
}

fn ldc(mut frame Frame, index u32) ! {
	mut stack := frame.operand_stack()
	pool := frame.method().class().constant_pool()
	constant := pool.get_constant() or {
		return error('Unable to retrieve constant from constant pool')
	}

	match constant {
		int {
			stack.push_int(constant)
		}
		f32 {
			stack.push_f32(constant)
		}
		// string {}
		// ClassRef {}
		// MethodType, MethodHandle {}
		else {
			return error('Unable to load unknown constant (ldc instruction)')
		}
	}
}
