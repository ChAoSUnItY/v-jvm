module heap

[inline]
fn (class &Class) is_assignable_from(other &Class) bool {
	return if class == other {
		true
	} else if !class.is_interface() {
		class.is_sub_class_of(other)
	} else {
		class.implements(other)
	}
}

fn (class &Class) is_sub_class_of(other &Class) bool {
	for super_class := class.super_class; !isnil(super_class); super_class = super_class.super_class {
		if class == other {
			return true
		}
	}
	return false
}

fn (class &Class) implements(other &Class) bool {
	for super_class := class.super_class; !isnil(super_class); super_class = super_class.super_class {
		for super_interface in super_class.interfaces {
			if super_interface == other || super_interface.is_sub_interface_of(other) {
				return true
			}
		}
	}
	return false
}

fn (class &Class) is_sub_interface_of(other &Class) bool {
	for super_interface in class.interfaces {
		if super_interface == other || super_interface.is_sub_interface_of(other) {
			return true
		}
	}
	return false
}
