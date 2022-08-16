module classfile

struct MemberInfo {
	pool             &ConstantPool
	access_flags     u16
	name_index       u16
	descriptor_index u16
	attributes       []&AttributeInfo
}

fn (mut reader ClassReader) read_members(pool &ConstantPool) []&MemberInfo {
	len := reader.read_u16()
	members := []&MemberInfo{len: len}

	for i in 0 .. len {
		members[i] = reader.read_member(pool)
	}

	return members
}

fn (mut reader ClassReader) read_member(pool &ConstantPool) &MemberInfo {
	return &MemberInfo{pool, reader.read_u16(), reader.read_u16(), reader.read_u16(), reader.read_attributes(pool)}
}
