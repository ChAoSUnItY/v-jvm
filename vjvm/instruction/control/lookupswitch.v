module control

import vjvm.instruction.base { BytecodeReader, branch }
import vjvm.rtda { Frame }

pub struct LOOKUP_SWITCH {
mut:
	default_offset int
	n_pairs        int
	match_offsets  []int = []int{}
}

pub fn (mut inst LOOKUP_SWITCH) fetch_operands(mut reader BytecodeReader) {
	reader.skip_padding()
	inst.default_offset = reader.read_int()
	inst.n_pairs = reader.read_int()
	inst.match_offsets = reader.read_int_arr(inst.n_pairs * 2)
}

pub fn (mut inst LOOKUP_SWITCH) execute(mut frame Frame) ! {
	mut stack := frame.operand_stack()
	key := stack.pop_int()
	for i := 0; i < inst.n_pairs * 2; i += 2 {
		if inst.match_offsets[i] == key {
			branch(mut frame, inst.match_offsets[i + 1])
			return
		}
	}
	branch(mut frame, inst.default_offset)
}
