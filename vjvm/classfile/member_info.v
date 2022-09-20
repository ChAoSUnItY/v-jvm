module classfile

pub struct MemberInfo {
	pool             &ConstantPool   [required]
	access_flags     u16
	name_index       u16
	descriptor_index u16
	attributes       []AttributeInfo
}

fn (mut reader ClassReader) read_members(pool &ConstantPool) ![]MemberInfo {
	len := reader.read_u16()
	mut members := []MemberInfo{cap: int(len)}

	for _ in 0 .. len {
		members << reader.read_member(pool)!
	}

	return members
}

fn (mut reader ClassReader) read_member(pool &ConstantPool) !MemberInfo {
	access_flags := reader.read_u16()
	name_index := reader.read_u16()
	descriptor_index := reader.read_u16()
	attributes := reader.read_attributes(pool)!
	return MemberInfo{unsafe { pool }, access_flags, name_index, descriptor_index, attributes}
}

pub fn (info &MemberInfo) access_flags() u16 {
	return info.access_flags
}

pub fn (info &MemberInfo) name() !string {
	return info.pool.get_utf8(info.name_index)!
}

pub fn (info &MemberInfo) descriptor() !string {
	return info.pool.get_utf8(info.descriptor_index)!
}

pub fn (info &MemberInfo) attributes() []AttributeInfo {
	return info.attributes
}

pub fn (info &MemberInfo) code_attr() ?&CodeAttribute {
	for attr in info.attributes {
		if attr is CodeAttribute {
			return attr
		}
	}
	return none
}

pub fn (info &MemberInfo) constant_value_attr() ?&ConstantValueAttribute {
	for attr in info.attributes {
		if attr is ConstantValueAttribute {
			return attr
		}
	}
	return none
}
