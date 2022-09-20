module vjvm

import vjvm.instruction { new_instruction }
import vjvm.instruction.base { BytecodeReader }
import vjvm.classfile { MemberInfo }
import vjvm.rtda { Frame, Thread, new_thread }
import vjvm.rtda.heap { Method }

pub fn interpret(method &Method) ! {
	mut thread := new_thread()
	mut frame := thread.new_frame(method)
	thread.push_frame(mut frame)! // Enter frame
	loop(mut thread, method.code()) or { catch_err(err, frame) }
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
	// println('Local vars: $frame.local_vars()')
	// println('Operand stack: $frame.operand_stack()')
	// panic(err.msg)
}
