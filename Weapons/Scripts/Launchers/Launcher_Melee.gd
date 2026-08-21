class_name Launcher_Melee extends WeaponLauncher

#plays blade animation and checks for clashes. If clashing - call event
signal clash_occured(object)


func spawn_one(projectile_prefab:PackedScene) -> Projectile:
	var projectile:Projectile = projectile_prefab.instantiate()
	
	projectile.position = Vector2.ZERO
	projectile.rotation = 0
	add_child(projectile)
	
	return projectile
