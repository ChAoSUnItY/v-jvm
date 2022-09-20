module heap

import vjvm.classfile { ConstantClassInfo, ConstantDoubleInfo, ConstantFieldRefInfo, ConstantFloatInfo, ConstantIntegerInfo, ConstantInterfaceRefInfo, ConstantLongInfo, ConstantMethodRefInfo, ConstantStringInfo }

pub interface Constant {}

pub struct ConstantPool {
mut:
	class     &Class
	constants []Constant
}

fn new_constant_pool(class &Class, cf_pool &classfile.ConstantPool) !ConstantPool {
	count := cf_pool.len
	constants := []Constant{cap: count}
	mut pool := ConstantPool{unsafe { class }, constants}

	for i := 1; i < count; i++ {
		info := (*cf_pool)[i]
		match info {
			ConstantIntegerInfo {
				pool.constants << Constant(info.value())
			}
			ConstantFloatInfo {
				pool.constants << Constant(info.value())
			}
			ConstantLongInfo {
				val := Constant(info.value())
				pool.constants << val
				pool.constants << val
			}
			ConstantDoubleInfo {
				val := Constant(info.value())
				pool.constants << val
				pool.constants << val
			}
			ConstantStringInfo {
				pool.constants << Constant(info.string()!)
			}
			ConstantClassInfo {
				pool.constants << new_class_ref(&pool, info)!
			}
			ConstantFieldRefInfo {
				pool.constants << new_field_ref(&pool, info)!
			}
			ConstantMethodRefInfo {
				pool.constants << new_method_ref(&pool, info)!
			}
			ConstantInterfaceRefInfo {
				pool.constants << new_interface_method_ref(&pool, info)!
			}
			else {
				// TODO
			}
		}
	}

	return pool
}

pub fn (pool &ConstantPool) get_constant(index u32) ?Constant {
	if constant := pool.constants[index] {
		return constant
	}
	return none
}
