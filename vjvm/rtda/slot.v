module rtda

struct Slot {
	num int
	ref &Object
}

fn new_num_slot(num int) Slot {
	return Slot{num, unsafe { nil }}
}

fn new_obj_slot(ref &Object) Slot {
	return Slot{0, ref}
}
