module heap

import vjvm.classfile { ClassFile }
import vjvm.rtda { Object }

pub struct Class {
	Access
	name string
	super_class_name string
	interface_names []string
	constant_pool ConstantPool
	fields []Field
	methods []Method
	loader ClassLoader
	super_class &Class
	interfaces []&Class
	instance_slot_count u32
	static_slot_count u32
	static_slots Slots
}

pub fn (mut class Class) from_class_file(cf &ClassFile) {
	
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
	return class.constant_pool
}

pub fn (class &Class) static_slots() &Slots {
	return class.static_slots
}

pub fn (class &Class) is_accessible_to(class2 &Class) bool {
	return class.is_public() || class.package_name() == class2.package_name()
}

pub fn (class &Class) package_name() string {
	i := class.name.last_index('/') or {
		return ''
	}
	return class.name[..i]
}

pub fn (class &Class) new_object() &Object {
	return new_object(class)
}
