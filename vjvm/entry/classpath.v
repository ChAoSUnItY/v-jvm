module entry

import os { exists, getenv_opt, join_path, join_path_single }

pub struct ClassPath {
	boot_classpath Entry
	ext_classpath  Entry
	user_classpath Entry
}

pub fn parse_cp(jre_option string, cp_option string) !ClassPath {
	boot_classpath, ext_classpath := parse_boot_ext_dir(jre_option)!
	user_classpath := parse_user_dir(cp_option)
	return ClassPath{boot_classpath, ext_classpath, user_classpath}
}

fn parse_boot_ext_dir(jre_option string) !(&Entry, &Entry) {
	jre_dir := get_jre_dir(jre_option)!

	jre_lib_dir := join_path(jre_dir, 'lib', '*')
	jre_lib_entry := new_wildcard_entry(jre_lib_dir)

	jre_ext_dir := join_path(jre_dir, 'lib', 'ext', '*')
	jre_ext_entry := new_wildcard_entry(jre_ext_dir)

	return jre_lib_entry, jre_ext_entry
}

fn get_jre_dir(jre_option string) !string {
	if jre_option.len != 0 && exists(jre_option) {
		return jre_option
	} else if exists('./jre') {
		return './jre'
	} else if jh := getenv_opt('JAVA_HOME') {
		return join_path_single(jh, 'jre')
	} else {
		return error('Cannot find Jre folder!')
	}
}

fn parse_user_dir(cp_option string) Entry {
	return new_entry(if cp_option.len == 0 { '.' } else { cp_option })
}

pub fn (classpath &ClassPath) read_class(class_name string) !([]u8, &Entry) {
	class_name_ := class_name + '.class'
	if bytecode, entry := classpath.boot_classpath.read_class(class_name_) {
		return bytecode, entry
	}
	if bytecode, entry := classpath.ext_classpath.read_class(class_name_) {
		return bytecode, entry
	}
	return classpath.user_classpath.read_class(class_name_)
}

fn (classpath &ClassPath) str() string {
	return classpath.user_classpath.str()
}
