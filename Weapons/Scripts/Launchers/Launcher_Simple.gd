class_name SimpleLauncher extends WeaponLauncher

func spawn_one(projectile_prefab:PackedScene) -> Projectile:
	var projectile:Projectile = ProjectileStorage.request_spawn(projectile_prefab)
	
	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	
	return projectile
