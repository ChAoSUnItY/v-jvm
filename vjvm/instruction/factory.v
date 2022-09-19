module instruction

import vjvm.instruction.base { Instruction }
import vjvm.instruction.comparison { DCMPG, DCMPL, FCMPG, FCMPL, IFEQ, IFGE, IFGT, IFLE, IFLT, IFNE, IF_ACMPEQ, IF_ACMPNE, IF_ICMPEQ, IF_ICMPGE, IF_ICMPGT, IF_ICMPLE, IF_ICMPLT, IF_ICMPNE, LCMP }
import vjvm.instruction.constant { ACONST_NULL, BIPUSH, DCONST_0, DCONST_1, FCONST_0, FCONST_1, FCONST_2, ICONST_0, ICONST_1, ICONST_2, ICONST_3, ICONST_4, ICONST_5, ICONST_M1, LCONST_0, LCONST_1, LDC, LDC2_W, LDC_W, NOP, SIPUSH }
import vjvm.instruction.control { GOTO, LOOKUP_SWITCH, TABLE_SWITCH }
import vjvm.instruction.conversion { D2F, D2I, D2L, F2D, F2I, F2L, I2B, I2C, I2D, I2F, I2L, I2S, L2D, L2F, L2I }
import vjvm.instruction.extended { GOTO_W, IFNONNULL, IFNULL, WIDE }
import vjvm.instruction.load { ALOAD, ALOAD_0, ALOAD_1, ALOAD_2, ALOAD_3, DLOAD, DLOAD_0, DLOAD_1, DLOAD_2, DLOAD_3, FLOAD, FLOAD_0, FLOAD_1, FLOAD_2, FLOAD_3, ILOAD, ILOAD_0, ILOAD_1, ILOAD_2, ILOAD_3, LLOAD, LLOAD_0, LLOAD_1, LLOAD_2, LLOAD_3 }
import vjvm.instruction.math { DADD, DDIV, DMUL, DNEG, DREM, DSUB, FADD, FDIV, FMUL, FNEG, FREM, FSUB, IADD, IAND, IDIV, IINC, IMUL, INEG, IOR, IREM, ISHL, ISHR, ISUB, IUSHR, IXOR, LADD, LAND, LDIV, LMUL, LNEG, LOR, LREM, LSHL, LSHR, LSUB, LUSHR, LXOR }
import vjvm.instruction.reference { CHECK_CAST, GET_FIELD, GET_STATIC, INSTANCE_OF, INVOKE_SPECIAL, INVOKE_VIRTUAL, NEW, PUT_FIELD, PUT_STATIC }
import vjvm.instruction.stack { DUP, DUP2, DUP2_X1, DUP2_X2, DUP_X1, DUP_X2, POP, POP2, SWAP }
import vjvm.instruction.store { ASTORE, ASTORE_0, ASTORE_1, ASTORE_2, ASTORE_3, DSTORE, DSTORE_0, DSTORE_1, DSTORE_2, DSTORE_3, FSTORE, FSTORE_0, FSTORE_1, FSTORE_2, FSTORE_3, ISTORE, ISTORE_0, ISTORE_1, ISTORE_2, ISTORE_3, LSTORE, LSTORE_0, LSTORE_1, LSTORE_2, LSTORE_3 }

const (
	nop         = NOP{}
	aconst_null = ACONST_NULL{}
	iconst_m1   = ICONST_M1{}
	iconst_0    = ICONST_0{}
	iconst_1    = ICONST_1{}
	iconst_2    = ICONST_2{}
	iconst_3    = ICONST_3{}
	iconst_4    = ICONST_4{}
	iconst_5    = ICONST_5{}
	lconst_0    = LCONST_0{}
	lconst_1    = LCONST_1{}
	fconst_0    = FCONST_0{}
	fconst_1    = FCONST_1{}
	fconst_2    = FCONST_2{}
	dconst_0    = DCONST_0{}
	dconst_1    = DCONST_1{}
	iload_0     = ILOAD_0{}
	iload_1     = ILOAD_1{}
	iload_2     = ILOAD_2{}
	iload_3     = ILOAD_3{}
	lload_0     = LLOAD_0{}
	lload_1     = LLOAD_1{}
	lload_2     = LLOAD_2{}
	lload_3     = LLOAD_3{}
	fload_0     = FLOAD_0{}
	fload_1     = FLOAD_1{}
	fload_2     = FLOAD_2{}
	fload_3     = FLOAD_3{}
	dload_0     = DLOAD_0{}
	dload_1     = DLOAD_1{}
	dload_2     = DLOAD_2{}
	dload_3     = DLOAD_3{}
	aload_0     = ALOAD_0{}
	aload_1     = ALOAD_1{}
	aload_2     = ALOAD_2{}
	aload_3     = ALOAD_3{}
	// iaload      = IALOAD{}
	// laload      = LALOAD{}
	// faload      = FALOAD{}
	// daload      = DALOAD{}
	// aaload      = AALOAD{}
	// baload      = BALOAD{}
	// caload      = CALOAD{}
	// saload      = SALOAD{}
	istore_0    = ISTORE_0{}
	istore_1    = ISTORE_1{}
	istore_2    = ISTORE_2{}
	istore_3    = ISTORE_3{}
	lstore_0    = LSTORE_0{}
	lstore_1    = LSTORE_1{}
	lstore_2    = LSTORE_2{}
	lstore_3    = LSTORE_3{}
	fstore_0    = FSTORE_0{}
	fstore_1    = FSTORE_1{}
	fstore_2    = FSTORE_2{}
	fstore_3    = FSTORE_3{}
	dstore_0    = DSTORE_0{}
	dstore_1    = DSTORE_1{}
	dstore_2    = DSTORE_2{}
	dstore_3    = DSTORE_3{}
	astore_0    = ASTORE_0{}
	astore_1    = ASTORE_1{}
	astore_2    = ASTORE_2{}
	astore_3    = ASTORE_3{}
	// iastore  = IASTORE{}
	// lastore  = LASTORE{}
	// fastore  = FASTORE{}
	// dastore  = DASTORE{}
	// aastore  = AASTORE{}
	// bastore  = BASTORE{}
	// castore  = CASTORE{}
	// sastore  = SASTORE{}
	pop         = POP{}
	pop2        = POP2{}
	dup         = DUP{}
	dup_x1      = DUP_X1{}
	dup_x2      = DUP_X2{}
	dup2        = DUP2{}
	dup2_x1     = DUP2_X1{}
	dup2_x2     = DUP2_X2{}
	swap        = SWAP{}
	iadd        = IADD{}
	ladd        = LADD{}
	fadd        = FADD{}
	dadd        = DADD{}
	isub        = ISUB{}
	lsub        = LSUB{}
	fsub        = FSUB{}
	dsub        = DSUB{}
	imul        = IMUL{}
	lmul        = LMUL{}
	fmul        = FMUL{}
	dmul        = DMUL{}
	idiv        = IDIV{}
	ldiv        = LDIV{}
	fdiv        = FDIV{}
	ddiv        = DDIV{}
	irem        = IREM{}
	lrem        = LREM{}
	frem        = FREM{}
	drem        = DREM{}
	ineg        = INEG{}
	lneg        = LNEG{}
	fneg        = FNEG{}
	dneg        = DNEG{}
	ishl        = ISHL{}
	lshl        = LSHL{}
	ishr        = ISHR{}
	lshr        = LSHR{}
	iushr       = IUSHR{}
	lushr       = LUSHR{}
	iand        = IAND{}
	land        = LAND{}
	ior         = IOR{}
	lor         = LOR{}
	ixor        = IXOR{}
	lxor        = LXOR{}
	i2l         = I2L{}
	i2f         = I2F{}
	i2d         = I2D{}
	l2i         = L2I{}
	l2f         = L2F{}
	l2d         = L2D{}
	f2i         = F2I{}
	f2l         = F2L{}
	f2d         = F2D{}
	d2i         = D2I{}
	d2l         = D2L{}
	d2f         = D2F{}
	i2b         = I2B{}
	i2c         = I2C{}
	i2s         = I2S{}
	lcmp        = LCMP{}
	fcmpl       = FCMPL{}
	fcmpg       = FCMPG{}
	dcmpl       = DCMPL{}
	dcmpg       = DCMPG{}
		// ireturn = IRETURN{}
		// lreturn = LRETURN{}
		// freturn = FRETURN{}
		// dreturn = DRETURN{}
		// areturn = ARETURN{}
		// _return = RETURN{}
		// arraylength   = ARRAY_LENGTH{}
		// athrow        = ATHROW{}
		// monitorenter  = MONITOR_ENTER{}
		// monitorexit   = MONITOR_EXIT{}
		// invoke_native = INVOKE_NATIVE{}
)

pub fn new_instruction(opcode u8) !Instruction {
	match opcode {
		0x00 {
			return base.Instruction(instruction.nop)
		}
		0x01 {
			return base.Instruction(instruction.aconst_null)
		}
		0x02 {
			return base.Instruction(instruction.iconst_m1)
		}
		0x03 {
			return base.Instruction(instruction.iconst_0)
		}
		0x04 {
			return base.Instruction(instruction.iconst_1)
		}
		0x05 {
			return base.Instruction(instruction.iconst_2)
		}
		0x06 {
			return base.Instruction(instruction.iconst_3)
		}
		0x07 {
			return base.Instruction(instruction.iconst_4)
		}
		0x08 {
			return base.Instruction(instruction.iconst_5)
		}
		0x09 {
			return base.Instruction(instruction.lconst_0)
		}
		0x0a {
			return base.Instruction(instruction.lconst_1)
		}
		0x0b {
			return base.Instruction(instruction.fconst_0)
		}
		0x0c {
			return base.Instruction(instruction.fconst_1)
		}
		0x0d {
			return base.Instruction(instruction.fconst_2)
		}
		0x0e {
			return base.Instruction(instruction.dconst_0)
		}
		0x0f {
			return base.Instruction(instruction.dconst_1)
		}
		0x10 {
			return base.Instruction(BIPUSH{})
		}
		0x11 {
			return base.Instruction(SIPUSH{})
		}
		0x12 {
			return base.Instruction(LDC{})
		}
		0x13 {
			return base.Instruction(LDC_W{})
		}
		0x14 {
			return base.Instruction(LDC2_W{})
		}
		0x15 {
			return base.Instruction(ILOAD{})
		}
		0x16 {
			return base.Instruction(LLOAD{})
		}
		0x17 {
			return base.Instruction(FLOAD{})
		}
		0x18 {
			return base.Instruction(DLOAD{})
		}
		0x19 {
			return base.Instruction(ALOAD{})
		}
		0x1a {
			return base.Instruction(instruction.iload_0)
		}
		0x1b {
			return base.Instruction(instruction.iload_1)
		}
		0x1c {
			return base.Instruction(instruction.iload_2)
		}
		0x1d {
			return base.Instruction(instruction.iload_3)
		}
		0x1e {
			return base.Instruction(instruction.lload_0)
		}
		0x1f {
			return base.Instruction(instruction.lload_1)
		}
		0x20 {
			return base.Instruction(instruction.lload_2)
		}
		0x21 {
			return base.Instruction(instruction.lload_3)
		}
		0x22 {
			return base.Instruction(instruction.fload_0)
		}
		0x23 {
			return base.Instruction(instruction.fload_1)
		}
		0x24 {
			return base.Instruction(instruction.fload_2)
		}
		0x25 {
			return base.Instruction(instruction.fload_3)
		}
		0x26 {
			return base.Instruction(instruction.dload_0)
		}
		0x27 {
			return base.Instruction(instruction.dload_1)
		}
		0x28 {
			return base.Instruction(instruction.dload_2)
		}
		0x29 {
			return base.Instruction(instruction.dload_3)
		}
		0x2a {
			return base.Instruction(instruction.aload_0)
		}
		0x2b {
			return base.Instruction(instruction.aload_1)
		}
		0x2c {
			return base.Instruction(instruction.aload_2)
		}
		0x2d {
			return base.Instruction(instruction.aload_3)
		}
		// case 0x2e:
		// 	return iaload
		// case 0x2f:
		// 	return laload
		// case 0x30:
		// 	return faload
		// case 0x31:
		// 	return daload
		// case 0x32:
		// 	return aaload
		// case 0x33:
		// 	return baload
		// case 0x34:
		// 	return caload
		// case 0x35:
		// 	return saload
		0x36 {
			return base.Instruction(ISTORE{})
		}
		0x37 {
			return base.Instruction(LSTORE{})
		}
		0x38 {
			return base.Instruction(FSTORE{})
		}
		0x39 {
			return base.Instruction(DSTORE{})
		}
		0x3a {
			return base.Instruction(ASTORE{})
		}
		0x3b {
			return base.Instruction(instruction.istore_0)
		}
		0x3c {
			return base.Instruction(instruction.istore_1)
		}
		0x3d {
			return base.Instruction(instruction.istore_2)
		}
		0x3e {
			return base.Instruction(instruction.istore_3)
		}
		0x3f {
			return base.Instruction(instruction.lstore_0)
		}
		0x40 {
			return base.Instruction(instruction.lstore_1)
		}
		0x41 {
			return base.Instruction(instruction.lstore_2)
		}
		0x42 {
			return base.Instruction(instruction.lstore_3)
		}
		0x43 {
			return base.Instruction(instruction.fstore_0)
		}
		0x44 {
			return base.Instruction(instruction.fstore_1)
		}
		0x45 {
			return base.Instruction(instruction.fstore_2)
		}
		0x46 {
			return base.Instruction(instruction.fstore_3)
		}
		0x47 {
			return base.Instruction(instruction.dstore_0)
		}
		0x48 {
			return base.Instruction(instruction.dstore_1)
		}
		0x49 {
			return base.Instruction(instruction.dstore_2)
		}
		0x4a {
			return base.Instruction(instruction.dstore_3)
		}
		0x4b {
			return base.Instruction(instruction.astore_0)
		}
		0x4c {
			return base.Instruction(instruction.astore_1)
		}
		0x4d {
			return base.Instruction(instruction.astore_2)
		}
		0x4e {
			return base.Instruction(instruction.astore_3)
		}
		// case 0x4f:
		// 	return iastore
		// case 0x50:
		// 	return lastore
		// case 0x51:
		// 	return fastore
		// case 0x52:
		// 	return dastore
		// case 0x53:
		// 	return aastore
		// case 0x54:
		// 	return bastore
		// case 0x55:
		// 	return castore
		// case 0x56:
		// 	return sastore
		0x57 {
			return base.Instruction(instruction.pop)
		}
		0x58 {
			return base.Instruction(instruction.pop2)
		}
		0x59 {
			return base.Instruction(instruction.dup)
		}
		0x5a {
			return base.Instruction(instruction.dup_x1)
		}
		0x5b {
			return base.Instruction(instruction.dup_x2)
		}
		0x5c {
			return base.Instruction(instruction.dup2)
		}
		0x5d {
			return base.Instruction(instruction.dup2_x1)
		}
		0x5e {
			return base.Instruction(instruction.dup2_x2)
		}
		0x5f {
			return base.Instruction(instruction.swap)
		}
		0x60 {
			return base.Instruction(instruction.iadd)
		}
		0x61 {
			return base.Instruction(instruction.ladd)
		}
		0x62 {
			return base.Instruction(instruction.fadd)
		}
		0x63 {
			return base.Instruction(instruction.dadd)
		}
		0x64 {
			return base.Instruction(instruction.isub)
		}
		0x65 {
			return base.Instruction(instruction.lsub)
		}
		0x66 {
			return base.Instruction(instruction.fsub)
		}
		0x67 {
			return base.Instruction(instruction.dsub)
		}
		0x68 {
			return base.Instruction(instruction.imul)
		}
		0x69 {
			return base.Instruction(instruction.lmul)
		}
		0x6a {
			return base.Instruction(instruction.fmul)
		}
		0x6b {
			return base.Instruction(instruction.dmul)
		}
		0x6c {
			return base.Instruction(instruction.idiv)
		}
		0x6d {
			return base.Instruction(instruction.ldiv)
		}
		0x6e {
			return base.Instruction(instruction.fdiv)
		}
		0x6f {
			return base.Instruction(instruction.ddiv)
		}
		0x70 {
			return base.Instruction(instruction.irem)
		}
		0x71 {
			return base.Instruction(instruction.lrem)
		}
		0x72 {
			return base.Instruction(instruction.frem)
		}
		0x73 {
			return base.Instruction(instruction.drem)
		}
		0x74 {
			return base.Instruction(instruction.ineg)
		}
		0x75 {
			return base.Instruction(instruction.lneg)
		}
		0x76 {
			return base.Instruction(instruction.fneg)
		}
		0x77 {
			return base.Instruction(instruction.dneg)
		}
		0x78 {
			return base.Instruction(instruction.ishl)
		}
		0x79 {
			return base.Instruction(instruction.lshl)
		}
		0x7a {
			return base.Instruction(instruction.ishr)
		}
		0x7b {
			return base.Instruction(instruction.lshr)
		}
		0x7c {
			return base.Instruction(instruction.iushr)
		}
		0x7d {
			return base.Instruction(instruction.lushr)
		}
		0x7e {
			return base.Instruction(instruction.iand)
		}
		0x7f {
			return base.Instruction(instruction.land)
		}
		0x80 {
			return base.Instruction(instruction.ior)
		}
		0x81 {
			return base.Instruction(instruction.lor)
		}
		0x82 {
			return base.Instruction(instruction.ixor)
		}
		0x83 {
			return base.Instruction(instruction.lxor)
		}
		0x84 {
			return base.Instruction(IINC{})
		}
		0x85 {
			return base.Instruction(instruction.i2l)
		}
		0x86 {
			return base.Instruction(instruction.i2f)
		}
		0x87 {
			return base.Instruction(instruction.i2d)
		}
		0x88 {
			return base.Instruction(instruction.l2i)
		}
		0x89 {
			return base.Instruction(instruction.l2f)
		}
		0x8a {
			return base.Instruction(instruction.l2d)
		}
		0x8b {
			return base.Instruction(instruction.f2i)
		}
		0x8c {
			return base.Instruction(instruction.f2l)
		}
		0x8d {
			return base.Instruction(instruction.f2d)
		}
		0x8e {
			return base.Instruction(instruction.d2i)
		}
		0x8f {
			return base.Instruction(instruction.d2l)
		}
		0x90 {
			return base.Instruction(instruction.d2f)
		}
		0x91 {
			return base.Instruction(instruction.i2b)
		}
		0x92 {
			return base.Instruction(instruction.i2c)
		}
		0x93 {
			return base.Instruction(instruction.i2s)
		}
		0x94 {
			return base.Instruction(instruction.lcmp)
		}
		0x95 {
			return base.Instruction(instruction.fcmpl)
		}
		0x96 {
			return base.Instruction(instruction.fcmpg)
		}
		0x97 {
			return base.Instruction(instruction.dcmpl)
		}
		0x98 {
			return base.Instruction(instruction.dcmpg)
		}
		0x99 {
			return base.Instruction(IFEQ{})
		}
		0x9a {
			return base.Instruction(IFNE{})
		}
		0x9b {
			return base.Instruction(IFLT{})
		}
		0x9c {
			return base.Instruction(IFGE{})
		}
		0x9d {
			return base.Instruction(IFGT{})
		}
		0x9e {
			return base.Instruction(IFLE{})
		}
		0x9f {
			return base.Instruction(IF_ICMPEQ{})
		}
		0xa0 {
			return base.Instruction(IF_ICMPNE{})
		}
		0xa1 {
			return base.Instruction(IF_ICMPLT{})
		}
		0xa2 {
			return base.Instruction(IF_ICMPGE{})
		}
		0xa3 {
			return base.Instruction(IF_ICMPGT{})
		}
		0xa4 {
			return base.Instruction(IF_ICMPLE{})
		}
		0xa5 {
			return base.Instruction(IF_ACMPEQ{})
		}
		0xa6 {
			return base.Instruction(IF_ACMPNE{})
		}
		0xa7 {
			return base.Instruction(GOTO{})
		}
		// case 0xa8:
		// 	return JSR{}
		// case 0xa9:
		// 	return RET{}
		0xaa {
			return base.Instruction(TABLE_SWITCH{})
		}
		0xab {
			return base.Instruction(LOOKUP_SWITCH{})
		}
		// case 0xac:
		// 	return ireturn
		// case 0xad:
		// 	return lreturn
		// case 0xae:
		// 	return freturn
		// case 0xaf:
		// 	return dreturn
		// case 0xb0:
		// 	return areturn
		// case 0xb1:
		// 	return _return
		0xb2 {
			return base.Instruction(GET_STATIC{})
		}
		0xb3 {
			return base.Instruction(PUT_STATIC{})
		}
		0xb4 {
			return base.Instruction(GET_FIELD{})
		}
		0xb5 {
			return base.Instruction(PUT_FIELD{})
		}
		0xb6 {
			return base.Instruction(INVOKE_VIRTUAL{})
		}
		0xb7 {
			return base.Instruction(INVOKE_SPECIAL{})
		}
		// case 0xb8:
		// 	return INVOKE_STATIC{}
		// case 0xb9:
		// 	return INVOKE_INTERFACE{}
		// case 0xba:
		// 	return INVOKE_DYNAMIC{}
		0xbb {
			return base.Instruction(NEW{})
		}
		// case 0xbc:
		// 	return NEW_ARRAY{}
		// case 0xbd:
		// 	return ANEW_ARRAY{}
		// case 0xbe:
		// 	return arraylength
		// case 0xbf:
		// 	return athrow
		0xc0 {
			return base.Instruction(CHECK_CAST{})
		}
		0xc1 {
			return base.Instruction(INSTANCE_OF{})
		}
		// case 0xc2:
		// 	return monitorenter
		// case 0xc3:
		// 	return monitorexit
		0xc4 {
			return base.Instruction(WIDE{})
		}
		// case 0xc5:
		// 	return MULTI_ANEW_ARRAY{}
		0xc6 {
			return base.Instruction(IFNULL{})
		}
		0xc7 {
			return base.Instruction(IFNONNULL{})
		}
		0xc8 {
			return base.Instruction(GOTO_W{})
		}
		// case 0xc9:
		// 	return JSR_W{}
		// case 0xca: breakpoint
		// case 0xfe: impdep1
		// case 0xff: impdep2
		else {
			return error('Unsupported opcode: 0x${opcode:x}')
		}
	}
}
