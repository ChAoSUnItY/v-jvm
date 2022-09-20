module heap

import vjvm.classfile { ConstantInterfaceRefInfo }

pub struct InterfaceMethodRef {
	MemberRef
mut:
	method &Method = unsafe { nil }
}

fn new_interface_method_ref(pool &ConstantPool, info &ConstantInterfaceRefInfo) !InterfaceMethodRef {
	mut ref := InterfaceMethodRef{}
	unsafe {
		ref.pool = pool
	}
	ref.copy_member_ref_info(&info.ConstantClassMemberRefInfo)!
	return ref
}

pub fn (mut ref InterfaceMethodRef) resolve_interface_method() !&Method {
	if isnil(ref.method) {
		ref.resolve_interface_method_ref()!
	}
	return ref.method
}

fn (mut ref InterfaceMethodRef) resolve_interface_method_ref() ! {
	// TODO
}
