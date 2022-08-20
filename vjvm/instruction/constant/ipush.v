module constant

import vjvm.rtda { Frame }
import vjvm.instruction.base { BytecodeReader }

pub struct BIPUSH {
mut:
	val i8
}

pub fn (mut inst BIPUSH) fetch_operands(mut reader BytecodeReader) {
	inst.val = reader.read_i8()
}

pub fn (mut inst BIPUSH) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	stack.push<int>(inst.val)
}

pub struct SIPUSH {
mut:
	val i16
}

pub fn (mut inst SIPUSH) fetch_operands(mut reader BytecodeReader) {
	inst.val = reader.read_i16()
}

pub fn (mut inst SIPUSH) execute(mut frame Frame) ! {
	mut stack := frame.opreand_stack()
	stack.push<int>(inst.val)
}
