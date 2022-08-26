module interpreter

import vjvm.instruction { new_instruction }
import vjvm.instruction.base { BytecodeReader }
import vjvm.classfile { MemberInfo }
import vjvm.rtda { Frame, Thread, new_thread }

pub fn interpret(info MemberInfo) ! {
	code := info.code_attr() or {
		return error('Member ${info.name()!} does not have code attribute')
	}
	max_locals := code.max_locals()
	max_stack := code.max_stack()
	bytecode := code.bytecode()
	mut thread := new_thread()
	mut frame := thread.new_frame(max_locals, max_stack)
	thread.push_frame(mut frame)! // Enter frame
	loop(mut thread, bytecode) or { catch_err(err, frame) }
}

fn loop(mut thread Thread, bytecode []byte) ! {
	mut frame := thread.pop_frame()!
	mut reader := BytecodeReader{}

	for {
		pc := frame.next_pc()
		thread.set_pc(pc)
		reader.reset(bytecode, pc)
		opcode := reader.read_u8()
		mut inst := new_instruction(opcode)!
		inst.fetch_operands(mut reader)
		frame.set_next_pc(reader.pc())

		println('pc: $pc, $inst')
		inst.execute(mut frame)!
	}
}

fn catch_err(err IError, frame Frame) {
	println('Local vars: $frame.local_vars()')
	println('Operand stack: $frame.operand_stack()')
	panic(err.msg)
}
