module main

import vjvm { interpret }
import vjvm.entry { parse_cp }
import vjvm.cmd { Cmd, parse_cmd }
import vjvm.rtda.heap { new_class_loader }

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
	class_path := parse_cp(cmd.x_jre_option, cmd.cp_option)!
	mut loader := new_class_loader(class_path)
	class_name := cmd.class_name.replace('.', '/')
	class := loader.load_class(class_name)!
	main_method := class.main_method() or {
		return error('Main method not found in class $cmd.class_name')
	}
	interpret(main_method)!
}
