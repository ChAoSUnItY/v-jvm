module classfile

type ConstantPool = []ConstantInfo

fn (mut reader ClassReader) read_constant_pool() ConstantPool {
	len := int(reader.read_u16())
	pool := []ConstantInfo{len: len}

	// The constant_pool table is indexed from 1 to constant_pool_count - 1.
	for i := 1; i < len; i++ {
		pool[i] = reader.read_constant_info(&pool)

		// http://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.5
		// All 8-byte constants take up two entries in the constant_pool table of the class file.
		// If a CONSTANT_Long_info or CONSTANT_Double_info structure is the item in the constant_pool
		// table at index n, then the next usable item in the pool is located at index n+2.
		// The constant_pool index n+1 must be valid but is considered unusable.
		if pool[i] is ConstantLongInfo || pool[i] is ConstantDoubleInfo {
			i++
		}
	}

	return pool
}

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
