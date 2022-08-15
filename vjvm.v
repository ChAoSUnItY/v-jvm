module main

import vjvm
import vjvm.cmd { parse_cmd }

fn main() {
	cmd := parse_cmd()?

	match true {
		cmd.help_flag {
			cmd.print_usage()
		}
		cmd.version_flag {
			println(vjvm.version)
		}
		else {}
	}

	println(cmd)
}
