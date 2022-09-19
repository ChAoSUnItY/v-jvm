module math

import vjvm.instruction.base { BytecodeReader }
import vjvm.rtda { Frame }

pub struct IINC {
pub mut:
	index  u32
	@const int
}

pub fn (mut inst IINC) fetch_operands(mut reader BytecodeReader) {
	inst.index = reader.read_u8()
	inst.@const = reader.read_i8()
}

pub fn (mut inst IINC) execute(mut frame Frame) ! {
	mut local := frame.local_vars()
	mut val := local.get_int(inst.index)!
	val += inst.@const
	local.set_int(val, inst.index)
}
