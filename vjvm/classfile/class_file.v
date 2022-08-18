module classfile

struct ClassFile {
	minor_version u16 = 0
	major_version u16 = 0
	pool          ConstantPool = []ConstantInfo{len: 0}
	access_flags  u16             = 0
	this_class    u16             = 0
	super_class   u16             = 0
	interfaces    []u16           = []u16{}
	fields        []MemberInfo    = []MemberInfo{len: 0}
	methods       []MemberInfo    = []MemberInfo{len: 0}
	attributes    []AttributeInfo = []AttributeInfo{len: 0}
}

fn (mut cf ClassFile) read(mut reader ClassReader) {
	cf.check_magic_number(mut reader)
	cf.check_version(mut reader)
	cf.pool = reader.read_constant_info()
	cf.read_access_flags(mut reader)
	cf.read_this_class(mut reader)
	cf.read_super_class(mut reader)
	cf.read_interface(mut reader)
	cf.fields = reader.read_members(cf.pool)
	cf.methods = reader.read_members(cf.pool)
	cf.attributes = reader.read_attributes(cf.pool)
}

fn (cf &ClassFile) check_magic_number(mut reader ClassReader) {
	magic := reader.read_u32()
	if magic != 0xCAFEBABE {
		panic('java.lang.ClassFormatError: Invlaid magic number.')
	}
}

fn (mut cf ClassFile) check_version(mut reader ClassReader) {
	cf.minor_version = reader.read_u16()
	cf.major_version = reader.read_u16()

	match cf.major_version {
		45 {
			return
		}
		46...52 {
			if self.minor_version == 0 {
				return
			}
		}
	}

	panic('java.lang.UnsupportedClassVersionError: Unsupported class version $cf.major_version')
}

fn (mut cf ClassFile) read_access_flags(mut reader ClassReader) {
	cf.access_flags = reader.read_u16()
}

fn (mut cf ClassFile) read_this_class(mut reader ClassReader) {
	cf.this_class = reader.read_u16()
}

fn (mut cf ClassFile) read_super_class(mut reader ClassReader) {
	cf.super_class = reader.read_u16()
}

fn (mut cf ClassFile) read_interface(mut reader ClassReader) {
	cf.interfaces = reader.read_u16_array()
}
