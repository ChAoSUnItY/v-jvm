module main

import vjvm { parse_cp }
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
			start_jvm(cmd)?
		}
	}
}

fn start_jvm(cmd &Cmd) ? {
	cp := parse_cp(cmd.x_jre_option, cmd.cp_option)?
	class_name := cmd.class.replace('.', '/')
	class_data, _ := cp.read_class(class_name) or {
		return error('Unable to find or load main class $cmd.class')
	}
	println(class_data)
}
