module heap

pub struct SymRef {
mut:
	pool       &ConstantPool = unsafe { nil }
	class_name string
	class      &Class = unsafe { nil }
}

pub fn (mut ref SymRef) resolve_class() !&Class {
	if isnil(ref.class) {
		ref.resolve_class_ref()!
	}
	return ref.class
}

fn (mut ref SymRef) resolve_class_ref() ! {
	mut pool_class := ref.pool.class
	class := pool_class.loader.load_class(ref.class_name)!
	if pool_class.is_accessible_to(class) {
		return error('java.lang.IllegalAccessError')
	}
	ref.class = class
}

pub fn (ref &SymRef) class() &Class {
	return ref.class
}

pub fn (ref &SymRef) class_name() string {
	return ref.class_name
}
