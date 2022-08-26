module main

import vjvm
import vjvm.entry { ClassPath, parse_cp }
import vjvm.cmd { Cmd, parse_cmd }
import vjvm.classfile { ClassFile, MemberInfo, parse_cf }
import vjvm.instruction.interpreter { interpret }
import vjvm.rtda

fn main() {
	cmd := parse_cmd()!

	match true {
		cmd.help_flag {
			cmd.print_usage()
		}
		cmd.version_flag {
			println(vjvm.version)
		}
		else {
			start_jvm(&cmd)!
		}
	}

	gc_check_leaks()
}

fn start_jvm(cmd &Cmd) ! {
	cp := parse_cp(cmd.x_jre_option, cmd.cp_option)!
	class_name := cmd.class_name.replace('.', '/')
	class_file := load_class(class_name, &cp)!
	if main := get_main_method(&class_file) {
		interpret(main)!
	} else {
		return error('Main method not found in class $cmd.class_name')
	}
}

fn load_class(class_name string, cp &ClassPath) !ClassFile {
	class_data, _ := cp.read_class(class_name)!
	class_file := parse_cf(class_data)!
	return class_file
}

fn get_main_method(class_file &ClassFile) ?MemberInfo {
	for method in class_file.methods() {
		if method.name()! == 'main' && method.descriptor()! == '([Ljava/lang/String;)V' {
			return method
		}
	}
	return none
}

fn print_class_info(cf &ClassFile) ! {
	println('version: $cf.major_version(), $cf.minor_version()')
	println('constants count: $cf.pool().len()')
	println('this class: ${cf.this_class()!}')
	println('super class: ${cf.super_class()!}')
	println('interfaces: ${cf.interfaces()!}')
	fields := cf.fields()
	println('fields count: $fields.len')
	for field in fields {
		println('\t${field.name()!}')
	}
	methods := cf.methods()
	println('methods count: $methods.len')
	for method in methods {
		println('\t${method.name()!}')
	}
}
