module heap

import vjvm.classfile { parse_cf }
import vjvm.entry { ClassPath, Entry }

pub struct ClassLoader {
	class_path &ClassPath
mut:
	class_map map[string]&Class
}

[inline]
fn new_class_loader(class_path &ClassPath) ClassLoader {
	return ClassLoader{
		class_path,
		{}
	}
}

[inline]
fn (mut loader ClassLoader) load_class(name string) !&Class {
	return loader.class_map[name] or {
		loader.load_non_array_class(name)!
	}
}

fn (mut loader ClassLoader) load_non_array_class(name string) !&Class {
	data, entry := loader.read_class(name) or {
		return err
	}
	mut class := loader.define_class(data)
	class.link()!
	println('[Loaded $name from $entry]')
	return class
}

fn (mut loader ClassLoader) read_class(name string) !([]u8, &Entry) {
	return loader.class_path.read_class(name) or {
		error('java.lang.ClassNotFoundException: $name')
	}
}

fn (mut loader ClassLoader) define_class(data []u8) !&Class {
	mut class := parse_class(data)!
	class.loader = loader
	loader.resolve_super_class(class)!
	loader.resolve_super_interfaces(class)!
	loader.class_map[class.name] = class
	return class
}

fn parse_class(data []u8) !&Class {
	class_file := parse_cf(data)!
	return new_class(class_file)
}

fn (mut loader ClassLoader) resolve_super_class(mut class Class) ! {
	if class.name != 'java/lang/Object' {
		class.super_class = loader.load_class(class.super_class_name)!
	}
}

fn (mut loader ClassLoader) resolve_super_interfaces(mut class Class) ! {
	if class.interface_names.len > 0 {
		class.interfaces = []&Class{cap: class.interface_names.len}
		for interface_name in class.interface_names {
			class.interfaces << loader.load_class(interface_name)!
		}
	}
}

fn (mut class Class) link() ! {
	class.verify()
	class.prepare()!
}

fn (class &Class) verify() {
	// TODO
}

fn (mut class Class) prepare() ! {
	class.calculate_instance_slot_ids()
	class.calculate_static_field_slot_ids()
	class.alloc_and_init_static_vars()
}

fn (mut class Class) calculate_instance_slot_ids() {
	mut slot_id := u32(0)
	if !ifnil(class.super_class) {
		slot_id = class.super_class.instance_slot_count
	}
	for mut field in class.fields {
		if !field.is_static() {
			field.slot_id = slot_id
			slot_id += if field.is_long_or_double() {
				2
			} else {
				1
			}
		}
	}
	class.instance_slot_count = slot_id
}

fn (mut class Class) calculate_static_field_slot_ids() {
	mut slot_id := u32(0)
	for mut field in class.fields {
		if field.is_static() {
			field.slot_id = slot_id
			slot_id += if field.is_long_or_double() {
				2
			} else {
				1
			}
		}
	}
	class.instance_slot_count = slot_id
}

fn (mut class Class) alloc_and_init_static_vars() ! {
	class.static_vars := new_slots(class.static_slot_count)
	for field in class.fields {
		if field.is_static() && field.is_final() {
			class.init_static_final_var(field) or {
				return error('Unable to init static variable `$field.name` from constant pool in class `$class.name`')
			}
		}
	}
}

fn (mut class Class) init_static_final_var(field &Field) ? {
	mut vars := class.static_vars
	pool := class.constant_pool
	index := field.const_value_index()
	slot_id := field.slot_id()

	if index > 0 {
		match field.descriptor() {
			"Z", "B", "C", "S", "I" {
				vars.set<int>(pool.get<int>(index)?)
			}
			'J' {
				vars.set<i64>(pool.get<i64>(index)?)
			}
			'F' {
				vars.set<f32>(pool.get<f32>(index)?)
			}
			'D' {
				vars.set<f64>(pool.get<f64>(index)?)
			}
			'Ljava/lang/String;' {
				panic('TODO')
			}
		}
	}
}
