module heap

import vjvm.classfile { MemberInfo }

pub struct Field {
	ClassMember
mut:
	const_value_index u32
	slot_id           u32
}

fn new_fields(class &Class, infos []MemberInfo) ![]&Field {
	mut fields := []&Field{cap: infos.len}
	for info in infos {
		mut field := &Field{
			class: unsafe { class }
		}
		field.copy_class_info(info)!
		field.copy_attributes(info)!
		fields << field
	}
	return fields
}

fn (mut field Field) copy_attributes(info &MemberInfo) ! {
	const_value_attr := info.constant_value_attr() or { return err }
	field.const_value_index = const_value_attr.index()
}

pub fn (field &Field) is_volatile() bool {
	return field.access_flags & acc_volatile != 0
}

pub fn (field &Field) is_transient() bool {
	return field.access_flags & acc_transient != 0
}

pub fn (field &Field) is_enum() bool {
	return field.access_flags & acc_enum != 0
}

pub fn (field &Field) const_value_index() u32 {
	return field.const_value_index
}

pub fn (field &Field) slot_id() u32 {
	return field.slot_id
}

pub fn (field &Field) is_long_or_double() bool {
	return field.descriptor == 'J' || field.descriptor == 'D'
}
