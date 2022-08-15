module cmd

import vjvm
import os
import flag

pub struct Cmd {
pub mut:
	help_flag    bool
	version_flag bool
	x_jre_option string
	cp_option    string
	class        string
	args         []string
}

pub fn parse_cmd() ?&Cmd {
	mut cmd := &Cmd{}
	mut fp := flag.new_flag_parser(os.args)
	fp.application('v jvm')
	fp.version(vjvm.version)
	fp.usage_example('Usage: ${os.args[0]} [-options] class [args...]\n')
	fp.skip_executable()

	cmd.help_flag = fp.bool('help', `h`, false, 'Show usage list')
	cmd.version_flag = fp.bool('version', `v`, false, 'Show version')
	cmd.x_jre_option = fp.string('xjre', 0, '', 'path to jre')
	cmd.cp_option = fp.string('cp', 0, '', 'classpath')

	additional_args := fp.finalize() or {
		eprintln(err)
		fp.usage()
		return cmd
	}

	if additional_args.len > 0 {
		cmd.class = additional_args[0]
		cmd.args = additional_args[1..]
	}

	return cmd
}

pub fn (cmd &Cmd) print_usage() {
	println('Usage: ${os.args[0]} [-options] class [args...]\n')
}
