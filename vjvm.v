module main

import vjvm
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
			start_jvm(cmd)
		}
	}
}

fn start_jvm(cmd &Cmd) {
}
