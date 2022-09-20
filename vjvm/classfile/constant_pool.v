module classfile

type ConstantPool = []ConstantInfo

fn (mut reader ClassReader) read_constant_pool() !ConstantPool {
	len := int(reader.read_u16())
	mut pool := []ConstantInfo{len: len, init: ConstantInfo(ConstantPlaceHolderInfo{})}

	// The constant_pool table is indexed from 1 to constant_pool_count - 1.
	for i := 1; i < len; i++ {
		info := reader.read_constant_info(&pool)!
		pool[i] = info

		// http://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.4.5
		// All 8-byte constants take up two entries in the constant_pool table of the class file.
		// If a CONSTANT_Long_info or CONSTANT_Double_info structure is the item in the constant_pool
		// table at index n, then the next usable item in the pool is located at index n+2.
		// The constant_pool index n+1 must be valid but is considered unusable.
		if info is ConstantLongInfo || info is ConstantDoubleInfo {
			i++
		}
	}

	return pool
}

fn (pool &ConstantPool) get_constant_info(index u16) ConstantInfo {
	if index >= pool.len {
		panic('Constant pool index out of bound')
	}
	return (*pool)[index]
}

fn (pool &ConstantPool) get_name_and_type(index u16) !(string, string) {
	info := pool.get_constant_info(index)
	if info is ConstantNameAndTypeInfo {
		return pool.get_utf8(info.name_index)!, pool.get_utf8(info.descriptor_index)!
	} else {
		return error('Constant pool index $index is not constant info NameAndType')
	}
}

fn (pool &ConstantPool) get_class_name(index u16) !string {
	info := pool.get_constant_info(index)
	if info is ConstantClassInfo {
		return pool.get_utf8(info.name_index)
	} else {
		return error('Constant pool index $index is not constant info Class')
	}
}

fn (pool &ConstantPool) get_utf8(index u16) !string {
	info := pool.get_constant_info(index)
	if info is ConstantUtf8Info {
		return info.str().after('&') // temporary workaround
	} else {
		return error('Constant pool index $index is not constant info Class')
	}
}
