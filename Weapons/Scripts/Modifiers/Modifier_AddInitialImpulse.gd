class_name Modifier_AddAdditionalImpulse extends WeaponModifier

func apply(spaceObject:SpaceObject, weapon:Weapon, projectiles:Array)->bool:
	#add impulse based on space object speed
	var movement:Movement = spaceObject.get_movement_or_null()
	if movement==null:
		return false
	
	for proj in projectiles:
		var projectile:Projectile = proj
		projectile.add_impulse(movement.get_velocity()*power)

	return true
