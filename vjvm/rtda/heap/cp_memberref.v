module heap

import vjvm.classfile { ConstantClassMemberRefInfo }

pub struct MemberRef {
	SymRef
mut:
	name       string
	descriptor string
}

fn (mut ref MemberRef) copy_member_ref_info(info &ConstantClassMemberRefInfo) ! {
	ref.class_name = info.class_name()!
	ref.name, ref.descriptor = info.name_and_descriptor()!
}

pub fn (ref &MemberRef) name() string {
	return ref.name
}

pub fn (ref &MemberRef) descriptor() string {
	return ref.descriptor
}
