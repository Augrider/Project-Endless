class_name Modifier_Recoil extends WeaponModifier

func apply(spaceObject:SpaceObject, weapon:Weapon, projectiles:Array)->bool:
	var movement:Movement = spaceObject.get_movement_or_null()
	if movement==null:
		return false
	
	#apply recoil as impulse to movement via method
	movement.add_impulse(-power*weapon.global_transform.x)
	return true
