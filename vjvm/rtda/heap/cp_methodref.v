module heap

import vjvm.classfile { ConstantMethodRefInfo }

pub struct MethodRef {
	MemberRef
mut:
	method &Method = unsafe { nil }
}

fn new_method_ref(pool &ConstantPool, info &ConstantMethodRefInfo) MethodRef {
	ref := MethodRef{}
	ref.pool = pool
	ref.copy_member_ref_info(info)
	return ref
}

fn (mut ref MethodRef) resolve_method() !&Method {
	if isnil(ref.method) {
		ref.resolve_method_ref()!
	}
	return ref.method
}

fn (mut ref MethodRef) resolve_method_ref() ! {
	// TODO
}
