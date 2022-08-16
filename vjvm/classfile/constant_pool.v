module classfile

type ConstantPool = []ConstantInfo

fn (pool &ConstantPool) get_constant_info(index u16) &ConstantInfo {
	if index >= pool.len {
		panic('Constant pool index out of bound')
	}
	return &pool[index]
}

fn (pool &ConstantPool) get_name_and_type(index u16) (string, string) {
	info := &ConstantNameAndTypeInfo(pool.get_constant_info(index))
	return pool.get_utf8(info.name_index), pool.get_utf8(info.descriptor_index)
}

fn (pool &ConstantPool) get_class_name(index u16) string {
	info := &ConstantClassInfo(pool.get_constant_info(index))
	return info.str()
}

fn (pool &ConstantPool) get_utf8(index u16) string {
	info := &ConstantUtf8Info(pool.get_constant_info(index))
	return info.str()
}
