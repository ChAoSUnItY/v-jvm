module heap

import vjvm.classfile { MemberInfo }

pub struct ClassMember {
	Access

	owner_class &Class [required]
mut:
	name string
	descriptor string
}

pub fn (mut member ClassMember) copy(info &MemberInfo) ! {
	member.access_flags = info.access_flags()
	member.name = info.name()!
	member.descriptor = info.descriptor()!
}

pub fn (member &ClassMember) name() string {
	return member.name
}

pub fn (member &ClassMember) descriptor() string {
	return member.descriptor
}

pub fn (member &ClassMember) class() &Class {
	return member.owner_class
}

pub fn (member &ClassMember) is_accessible_to(class &Class) bool {
	if member.is_public() {
		return true
	}

	owner_class := member.owner_class

	if member.is_protected() {
		return owner_class == class || class.is_sub_class_of(owner_class) || class.package_name() == owner_class.package_name()
	} else if !member.is_private() {

	} else {
		return owner_class == class
	}
}
