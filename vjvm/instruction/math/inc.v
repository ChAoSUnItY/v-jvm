module math

import vjvm.rtda { Frame }
import vjvm.instruction.base { BytecodeReader }

pub struct IINC {
mut:
	index  int
	@const int
}

pub fn (mut inst IINC) fetch_operands(mut reader BytecodeReader) ! {
	inst.index = reader.read_u8()
	inst.@const = reader.read_i8()
}

pub fn (mut inst IINC) execute(mut frame Frame) ! {
	mut local := frame.local_vars()
	mut val := local.get<int>(inst.index)!
	val += inst.@const
	local.set<int>(val, inst.index)
}
