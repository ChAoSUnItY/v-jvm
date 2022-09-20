module heap

import vjvm.classfile { ClassFile }

pub struct Class {
	Access
mut:
	loader              ClassLoader
	name                string
	super_class_name    string
	super_class         &Class = unsafe { nil }
	interface_names     []string
	interfaces          []&Class
	constant_pool       ConstantPool
	fields              []&Field
	methods             []&Method
	static_vars         Slots
	static_slot_count   u32
	instance_slot_count u32
}

pub fn new_class(cf &ClassFile) !Class {
	mut class := Class{}
	class.access_flags = cf.access_flags()
	class.name = cf.name()!
	class.super_class_name = cf.super_class_name()!
	class.interface_names = cf.interface_names()!
	class.constant_pool = new_constant_pool(class, cf.constant_pool())!
	class.fields = new_fields(class, cf.fields())!
	class.methods = new_methods(class, cf.methods())!
	return class
}

pub fn (class &Class) is_interface() bool {
	return class.access_flags & acc_interface != 0
}

pub fn (class &Class) is_abstract() bool {
	return class.access_flags & acc_abstract != 0
}

pub fn (class &Class) is_annotation() bool {
	return class.access_flags & acc_annotation != 0
}

pub fn (class &Class) is_enum() bool {
	return class.access_flags & acc_enum != 0
}

pub fn (class &Class) constant_pool() &ConstantPool {
	return &class.constant_pool
}

pub fn (class &Class) static_slots() Slots {
	return class.static_vars
}

pub fn (class &Class) is_accessible_to(class2 &Class) bool {
	return class.is_public() || class.package_name() == class2.package_name()
}

pub fn (class &Class) package_name() string {
	i := class.name.last_index('/') or { return '' }
	return class.name[..i]
}

pub fn (class &Class) main_method() ?Method {
	return class.static_method('main', '([Ljava/lang/String;)V')
}

pub fn (class &Class) static_method(name string, descriptor string) ?Method {
	for method in class.methods {
		if method.is_static() && method.name() == name && method.descriptor() == descriptor {
			return *method
		}
	}

	return none
}

pub fn (class &Class) new_object() Object {
	return new_object(class)
}
