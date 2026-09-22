class_name MeleeLauncher extends WeaponLauncher

func spawn_one(projectile_prefab:PackedScene) -> Projectile:
	var projectile:Projectile = projectile_prefab.instantiate()
	
	projectile.position = Vector2.ZERO
	projectile.rotation = 0
	add_child(projectile)
	
	return projectile
