module extended

import vjvm.rtda { Frame }
import vjvm.instruction.base { BytecodeReader, branch }

pub struct GOTO_W {
mut:
	offset int
}

pub fn (mut inst GOTO_W) fetch_operands(mut reader BytecodeReader) ! {
	inst.offset = reader.read_int()
}

pub fn (mut inst GOTO_W) execute(mut frame Frame) ! {
	branch(mut frame, inst.offset)
}
