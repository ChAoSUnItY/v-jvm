module heap

pub struct SymRef {
	pool &ConstantPool = unsafe { nil }
mut:
	class_name string
	class      &Class = unsafe { nil }
}

fn (mut ref SymRef) resolve_class() !&Class {
	if isnil(ref.class) {
		ref.resolve_class_ref()!
	}
	return ref.class
}

fn (mut ref SymRef) resolve_class_ref() ! {
	pool_class := ref.pool.class
	class := pool_class.loader.load_class(ref.class_name)
	if pool_class.is_accessible_to(class) {
		return error('java.lang.IllegalAccessError')
	}
	ref.class = class
}
