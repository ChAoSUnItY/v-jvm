module heap

const (
	acc_public       = 0x0001 // class field method
	acc_private      = 0x0002 //       field method
	acc_protected    = 0x0004 //       field method
	acc_static       = 0x0008 //       field method
	acc_final        = 0x0010 // class field method
	acc_super        = 0x0020 // class
	acc_synchronized = 0x0020 //             method
	acc_volatile     = 0x0040 //       field
	acc_bridge       = 0x0040 //             method
	acc_transient    = 0x0080 //       field
	acc_varargs      = 0x0080 //             method
	acc_native       = 0x0100 //             method
	acc_interface    = 0x0200 // class
	acc_abstract     = 0x0400 // class       method
	acc_strict       = 0x0800 //             method
	acc_synthetic    = 0x1000 // class field method
	acc_annotation   = 0x2000 // class
	acc_enum         = 0x4000 // class field
)

struct Access {
mut:
	access_flags u16
}

pub fn (acc &Access) is_public() bool {
	return acc.access_flags & heap.acc_public != 0
}

pub fn (acc &Access) is_private() bool {
	return acc.access_flags & heap.acc_private != 0
}

pub fn (acc &Access) is_protected() bool {
	return acc.access_flags & heap.acc_protected != 0
}

pub fn (acc &Access) is_static() bool {
	return acc.access_flags & heap.acc_static != 0
}

pub fn (acc &Access) is_final() bool {
	return acc.access_flags & heap.acc_final != 0
}

pub fn (acc &Access) is_synthetic() bool {
	return acc.access_flags & heap.acc_synthetic != 0
}
