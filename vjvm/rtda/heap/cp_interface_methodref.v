module heap

import vjvm.classfile { ConstantInterfaceMethodRefInfo }

pub struct InterfaceMethodRef {
	MemberRef
mut:
	method &Method = unsafe { nil }
}

fn new_interface_method_ref(pool &ConstantPool, info &ConstantInterfaceMethodRefInfo) InterfaceMethodRef {
	ref := InterfaceMethodRef{}
	ref.pool = pool
	ref.copy_member_ref_info(info)
	return ref
}

fn (mut ref InterfaceMethodRef) resolve_interface_method() !&Method {
	if isnil(ref.method) {
		ref.resolve_method_ref()!
	}
	return ref.method
}

fn (mut ref InterfaceMethodRef) resolve_interface_method_ref() ! {
	// TODO
}

