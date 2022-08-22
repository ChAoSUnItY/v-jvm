module instruction

import vjvm.instruction.base
import vjvm.instruction.constant { ACONST_NULL, DCONST_0, DCONST_1, FCONST_0, FCONST_1, FCONST_2, ICONST_0, ICONST_1, ICONST_2, ICONST_3, ICONST_4, ICONST_5, ICONST_M1, LCONST_0, LCONST_1, NOP }
import vjvm.instruction.conversion
import vjvm.instruction.extended
import vjvm.instruction.load { ALOAD_0, ALOAD_1, ALOAD_2, ALOAD_3, DLOAD_0, DLOAD_1, DLOAD_2, DLOAD_3, FLOAD_0, FLOAD_1, FLOAD_2, FLOAD_3, ILOAD_0, ILOAD_1, ILOAD_2, ILOAD_3, LLOAD_0, LLOAD_1, LLOAD_2, LLOAD_3 }
import vjvm.instruction.math
import vjvm.instruction.stack
import vjvm.instruction.store

__global (
	nop         = &NOP{}
	aconst_null = &ACONST_NULL{}
	iconst_m1   = &ICONST_M1{}
	iconst_0    = &ICONST_0{}
	iconst_1    = &ICONST_1{}
	iconst_2    = &ICONST_2{}
	iconst_3    = &ICONST_3{}
	iconst_4    = &ICONST_4{}
	iconst_5    = &ICONST_5{}
	lconst_0    = &LCONST_0{}
	lconst_1    = &LCONST_1{}
	fconst_0    = &FCONST_0{}
	fconst_1    = &FCONST_1{}
	fconst_2    = &FCONST_2{}
	dconst_0    = &DCONST_0{}
	dconst_1    = &DCONST_1{}
	iload_0     = &ILOAD_0{}
	iload_1     = &ILOAD_1{}
	iload_2     = &ILOAD_2{}
	iload_3     = &ILOAD_3{}
	lload_0     = &LLOAD_0{}
	lload_1     = &LLOAD_1{}
	lload_2     = &LLOAD_2{}
	lload_3     = &LLOAD_3{}
	fload_0     = &FLOAD_0{}
	fload_1     = &FLOAD_1{}
	fload_2     = &FLOAD_2{}
	fload_3     = &FLOAD_3{}
	dload_0     = &DLOAD_0{}
	dload_1     = &DLOAD_1{}
	dload_2     = &DLOAD_2{}
	dload_3     = &DLOAD_3{}
	aload_0     = &ALOAD_0{}
	aload_1     = &ALOAD_1{}
	aload_2     = &ALOAD_2{}
	aload_3     = &ALOAD_3{}
)
