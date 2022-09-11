module heap

import vjvm.classfile { MemberInfo }

pub struct Method {
	ClassMember
mut:
	max_stack  u32
	max_locals u32
	code       []u8
}

fn new_methods(class &Class, infos []&MemberInfo) ![]&Method {
	mut methods := []&Method{cap: class_methods.len}
	for info in infos {
		mut method := &Method{}
		method.class = class
		method.copy_class_memeber(info)!
		method.copy_attributes(info)
		methods << method
	}
	return methods
}

fn (mut method Method) copy_attributes(info &MemberInfo) ! {
	code_attr := info.code_attr() or { return err }
	method.max_stack = code_attr.max_stack()
	method.max_locals = code_attr.max_locals()
	method.code = code_attr.code()
}

fn (method &Method) is_synchronized() bool {
	return method.access_flags & acc_synchronized != 0
}

fn (method &Method) is_bridge() bool {
	return method.access_flags & acc_bridge != 0
}

fn (method &Method) is_varargs() bool {
	return method.access_flags & acc_varargs != 0
}

fn (method &Method) is_native() bool {
	return method.access_flags & acc_native != 0
}

fn (method &Method) is_abstract() bool {
	return method.access_flags & acc_abstract != 0
}

fn (method &Method) is_strict() bool {
	return method.access_flags & acc_strict != 0
}

fn (method &Method) max_stack() u32 {
	return method.max_stack
}

fn (method &Method) max_locals() u32 {
	return method.max_locals
}

fn (method &Method) code() []u8 {
	return method.code
}
