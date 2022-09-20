module heap

import vjvm.classfile { ConstantClassInfo }

pub struct ClassRef {
	SymRef
}

fn new_class_ref(pool &ConstantPool, info &ConstantClassInfo) !ClassRef {
	mut class_ref := ClassRef{}
	unsafe {
		class_ref.pool = pool
	}
	class_ref.class_name = info.class_name()!
	return class_ref
}
