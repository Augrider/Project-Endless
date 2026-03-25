class_name Modifier_FollowLauncher extends WeaponModifier

func apply(spaceObject:SpaceObject, weapon:Weapon, projectiles:Array)->bool:
	#set projectile as a child of weapon, save relative position
	for proj in projectiles:
		var projectile:Projectile = proj
		
		if projectile.get_parent():
			projectile.get_parent().remove_child(projectile)
		
		weapon.add_child(projectile)
	
	return true
