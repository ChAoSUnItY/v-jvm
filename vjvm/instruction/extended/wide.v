module extended

import vjvm.rtda { Frame }
import vjvm.instruction.base { BytecodeReader, Instruction }
import vjvm.instruction.load { ALOAD, DLOAD, FLOAD, ILOAD, LLOAD }
import vjvm.instruction.store { ASTORE, DSTORE, FSTORE, ISTORE, LSTORE }
import vjvm.instruction.math { IINC }

pub struct WIDE {
mut:
	modified_instruction &Instruction = unsafe { nil }
}

pub fn (mut inst WIDE) fetch_operands(mut reader BytecodeReader) {
	opcode := reader.read_u8()
	match opcode {
		0x15 {
			mut inst_ := &ILOAD{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x16 {
			mut inst_ := &LLOAD{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x17 {
			mut inst_ := &FLOAD{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x18 {
			mut inst_ := &DLOAD{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x19 {
			mut inst_ := &ALOAD{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x36 {
			mut inst_ := &ISTORE{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x37 {
			mut inst_ := &LSTORE{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x38 {
			mut inst_ := &FSTORE{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x39 {
			mut inst_ := &DSTORE{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x3a {
			mut inst_ := &ASTORE{}
			inst_.index = u32(reader.read_u16())
			inst.modified_instruction = inst_
		}
		0x84 {
			mut inst_ := &IINC{}
			inst_.index = u32(reader.read_u16())
			inst_.@const = int(reader.read_i16())
			inst.modified_instruction = inst_
		}
		0xa9 {
			panic('Unsupported opcode: 0xa9')
		}
		else {}
	}
}

pub fn (mut inst WIDE) execute(mut frame Frame) ! {
	inst.modified_instruction.execute(mut frame)!
}
