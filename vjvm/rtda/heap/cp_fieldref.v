module heap

import vjvm.classfile { ConstantFieldRefInfo }

pub struct FieldRef {
	MemberRef
mut:
	field &Field = unsafe { nil }
}

fn new_field_ref(pool &ConstantPool, info &ConstantFieldRefInfo) FieldRef {
	mut ref := FieldRef{}
	ref.pool = pool
	ref.copy_member_ref_info(info)
	return ref
}

fn (mut ref FieldRef) resolve_field() !&FieldRef {
	if isnil(ref.field) {
		ref.resolve_field_ref()!
	}
	return ref.field
}

fn (mut ref FieldRef) resolve_field_ref() ! {
	pool_class := ref.pool.class
	class := ref.resolve_class()!
	field := lookup_field(class, ref.name, ref.descriptor) or {
		return error('java.lang.NoSuchFieldError')
	}

	if !field.is_accessible_to(pool_class) {
		return error('java.lang.IllegalAccessError')
	}

	ref.field = field
}

fn lookup_field(class &Class, name string, descriptor string) ?Field {
	for field in class.fields {
		if field.name == name && field.descriptor == descriptor {
			return field
		}
	}

	for super_interface in class.interfaces {
		if field := lookup_field(super_interface, name, descriptor) {
			return field
		}
	}

	if !isnil(class.super_class) {
		return lookup_field(class.super_class, name, descriptor)
	}

	return none
}
