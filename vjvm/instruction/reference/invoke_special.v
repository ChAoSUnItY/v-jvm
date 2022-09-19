module reference

import vjvm.instruction.base { Index16Instruction }
import vjvm.rtda { Frame }

pub struct INVOKE_SPECIAL {
	Index16Instruction
}

pub fn (mut inst INVOKE_SPECIAL) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	stack.pop_ref() // FIXME: hack
}
