module heap

pub struct Object {
	class  &Class
	fields Slots
}

fn new_object(class &Class) Object {
	return Object{unsafe { class }, new_slots(int(class.instance_slot_count))}
}

pub fn (obj &Object) class() &Class {
	return obj.class
}

pub fn (obj &Object) fields() Slots {
	return obj.fields
}

pub fn (obj &Object) is_instance_of(class &Class) bool {
	return class.is_assignable_from(obj.class)
}
