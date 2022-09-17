module heap

import vjvm.classfile { ConstantIntegerInfo, ConstantFloatInfo, ConstantLongInfo, ConstantDoubleInfo, ConstantStringInfo, ConstantClassInfo, ConstantFieldRefInfo, ConstantMethodRefInfo, ConstantInterfaceMethodRefInfo }

pub interface Constant {}

pub struct ConstantPool {
mut:
	class &Class
	constants []Constant
}

fn new_constant_pool(class &Class, cf_pool &classfile.ConstantPool) !ConstantPool {
	count := cf_pool.len()
	constants := []Constant{cap:pool}
	pool := ConstantPool{class, constants}

	for i := 1; i < count; i++ {
		info := cf_pool[i]
		match info {
			ConstantIntegerInfo {
				pool.constants << Constant(info.value())
			}
			ConstantFloatInfo {
				pool.constants << Constant(info.value())
			}
			ConstantLongInfo {
				val := Constant(info.value())
				pool.constants << Constant(info.value())
				pool.constants << Constant(info.value())
			}
			ConstantDoubleInfo {
				val := Constant(info.value())
				pool.constants << Constant(info.value())
				pool.constants << Constant(info.value())
			}
			ConstantStringInfo {
				pool.constants << Constant(info.string()!)
			}
			ConstantClassInfo {
				pool.constants << new_class_ref(&pool, info)
			}
			ConstantFieldRefInfo {
				pool.constants << new_field_ref(&pool, info)
			}
			ConstantMemberRefInfo {
				pool.constants << new_member_ref(&pool, info)
			}
			ConstantInterfaceMethodRefInfo {
				pool.constants << new_interface_method_ref(&pool, info)
			}
			else {
				// TODO
			}
		}
	}
}

fn (pool &ConstantPool) get_constant(index u32) ?Consatnt {
	if constant := pool.constants[index] {
		return constant
	}
	return none
}

fn (pool &ConstantPool) get<T>(index u32) ?T {
	return T(pool.get_constant(index)?)
}
