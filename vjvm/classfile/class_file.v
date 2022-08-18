module classfile

/*
ClassFile {
    u4             magic;
    u2             minor_version;
    u2             major_version;
    u2             constant_pool_count;
    cp_info        constant_pool[constant_pool_count-1];
    u2             access_flags;
    u2             this_class;
    u2             super_class;
    u2             interfaces_count;
    u2             interfaces[interfaces_count];
    u2             fields_count;
    field_info     fields[fields_count];
    u2             methods_count;
    method_info    methods[methods_count];
    u2             attributes_count;
    attribute_info attributes[attributes_count];
}
*/
pub struct ClassFile {
pub mut:
	minor_version u16
	major_version u16
	pool          ConstantPool = ConstantPool{}
	access_flags  u16
	this_class    u16
	super_class   u16
	interfaces    []u16           = []u16{}
	fields        []MemberInfo    = []MemberInfo{}
	methods       []MemberInfo    = []MemberInfo{}
	attributes    []AttributeInfo = []AttributeInfo{}
}

pub fn parse_cf(bytecode []u8) !ClassFile {
	mut reader := ClassReader{bytecode}
	mut class_file := ClassFile{}
	class_file.read(mut reader)!
	return class_file
}

fn (mut cf ClassFile) read(mut reader ClassReader) ! {
	cf.check_magic_number(mut reader)!
	cf.check_version(mut reader)!
	cf.pool = reader.read_constant_pool()!
	cf.access_flags = reader.read_u16()
	cf.this_class = reader.read_u16()
	cf.super_class = reader.read_u16()
	cf.interfaces = reader.read_u16_array()
	cf.fields = reader.read_members(cf.pool)!
	cf.methods = reader.read_members(cf.pool)!
	cf.attributes = reader.read_attributes(cf.pool)!
}

fn (cf &ClassFile) check_magic_number(mut reader ClassReader) ! {
	magic := reader.read_u32()
	if magic != 0xCAFEBABE {
		return error('java.lang.ClassFormatError: Invlaid magic number.')
	}
}

fn (mut cf ClassFile) check_version(mut reader ClassReader) ! {
	cf.minor_version = reader.read_u16()
	cf.major_version = reader.read_u16()

	match cf.major_version {
		45 {
			return
		}
		46...52 {
			if cf.minor_version == 0 {
				return
			}
		}
		else {}
	}

	return error('java.lang.UnsupportedClassVersionError: Unsupported class version $cf.major_version')
}
