extends WeaponLauncher

#func spawn(projectile_prefab:PackedScene, amount:int=1)->Array[Projectile]:
	#var result:Array[Projectile]
	#
	#for i in amount:
		#var projectile:Projectile = projectile_prefab.instantiate()
		#
		#projectile.global_position = global_position
		#projectile.global_rotation = global_rotation
		#
		#get_tree().root.add_child(projectile)
		#
		#result.append(projectile)
	#
	#return result

func spawn_one(projectile_prefab:PackedScene) -> Projectile:
	var projectile:Projectile = projectile_prefab.instantiate()
	
	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	
	get_tree().root.add_child(projectile)
	
	return projectile
