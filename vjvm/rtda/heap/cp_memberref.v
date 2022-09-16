module heap

import vjvm.classfile { ConstantMemberRefInfo }

pub struct MemberRef {
	SymRef
mut:
	name string
	descriptor string
}

fn (mut ref MemberRef) copy_member_ref_info(info &ConstantMemberRefInfo) {
	ref.class_name = info.class_name()
	ref.name, ref.descriptor = info.name_and_descriptor()!
}

fn (ref &MemberRef) name() string {
	return ref.name
}

fn (ref &MemberRef) descriptor() string {
	return ref.descriptor
}
