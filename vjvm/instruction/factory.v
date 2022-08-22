module instruction

import vjvm.instruction.base
import vjvm.instruction.constant { NOP }
import vjvm.instruction.conversion
import vjvm.instruction.extended
import vjvm.instruction.load
import vjvm.instruction.math
import vjvm.instruction.stack
import vjvm.instruction.store

__global (
	nop = &NOP{}
)
