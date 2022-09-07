module heap

struct Object {
	class &Class
	fields Slots
}

fn new_object(class &Class) &Object {
	return Object {
		class,
		new_slots(class.instance_slots_count)
	}
}

fn (obj &Object) class() &Class {
	return obj.class
}

fn (obj &Object) fields() Slots {
	return obj.fields
}

fn (obj &Object) is_instance_of(class &Class) bool {
	return class.is_assignable_from(obj.class)
}
