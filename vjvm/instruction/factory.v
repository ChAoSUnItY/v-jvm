module instruction

import vjvm.instruction.base
import vjvm.instruction.constant { NOP }
import vjvm.instruction.load
import vjvm.instruction.store

__global (
	nop = &NOP{}
)
