module classfile

struct MemberInfo {
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
	return MemberInfo{pool, access_flags, name_index, descriptor_index, attributes}
}
