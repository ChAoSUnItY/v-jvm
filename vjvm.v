module main

import vjvm
import vjvm.entry { parse_cp }
import vjvm.cmd { Cmd, parse_cmd }

fn main() {
	cmd := parse_cmd()?

	match true {
		cmd.help_flag {
			cmd.print_usage()
		}
		cmd.version_flag {
			println(vjvm.version)
		}
		else {
			start_jvm(&cmd)?
		}
	}

	gc_check_leaks()
}

fn start_jvm(cmd &Cmd) ? {
	cp := parse_cp(cmd.x_jre_option, cmd.cp_option)?
	class_name := cmd.class_name.replace('.', '/')
	class_data, _ := cp.read_class(class_name) or {
		return error('Unable to find or load main class $cmd.class_name')
	}
	println(class_data)
}
