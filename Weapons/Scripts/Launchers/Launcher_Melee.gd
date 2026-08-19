class_name Launcher_Melee extends WeaponLauncher

#plays blade animation and checks for clashes. If clashing - call event
signal clash_occured(object)


func spawn(projectile_prefab:PackedScene, amount:int=1)->Array[Projectile]:
	var result:Array[Projectile]
	
	for i in amount:
		var projectile:Projectile = projectile_prefab.instantiate()
		
		projectile.position = Vector2.ZERO
		projectile.rotation = 0
		add_child(projectile)
		
		result.append(projectile)
	
	return result
