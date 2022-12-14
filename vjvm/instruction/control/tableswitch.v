module control

import vjvm.instruction.base { BytecodeReader, branch }
import vjvm.rtda { Frame }

pub struct TABLE_SWITCH {
mut:
	default_offset int
	low            int
	high           int
	jump_offsets   []int = []int{}
}

pub fn (mut inst TABLE_SWITCH) fetch_operands(mut reader BytecodeReader) {
	reader.skip_padding()
	inst.default_offset = reader.read_int()
	inst.low = reader.read_int()
	inst.high = reader.read_int()
	jump_offsets_count := inst.high - inst.low + 1
	inst.jump_offsets = reader.read_int_arr(jump_offsets_count)
}

pub fn (mut inst TABLE_SWITCH) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	index := stack.pop_int()

	offset := if index >= inst.low && index <= inst.high {
		inst.jump_offsets[index - inst.low]
	} else {
		inst.default_offset
	}

	branch(mut frame, offset)
}
