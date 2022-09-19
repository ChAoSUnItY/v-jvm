module extended

import vjvm.instruction.base { BytecodeReader, branch }
import vjvm.rtda { Frame }

pub struct GOTO_W {
mut:
	offset int
}

pub fn (mut inst GOTO_W) fetch_operands(mut reader BytecodeReader) {
	inst.offset = reader.read_int()
}

pub fn (mut inst GOTO_W) execute(mut frame Frame) ! {
	branch(mut frame, inst.offset)
}
