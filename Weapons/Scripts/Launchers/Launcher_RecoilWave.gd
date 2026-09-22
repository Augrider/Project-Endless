class_name RecoilWaveLauncher extends RecoilLauncher

@export var step_pi: float = 0.25

var deviation_normalized: float = 0


func _process(delta: float) -> void:
	_set_recoil_normalized(recoil_normalized - recoil_control * delta)


func shoot_once(projectile_prefab: PackedScene, projectile_amount: int = 1) -> Array[Projectile]:
	var projectiles: Array[Projectile]
	
	for i in projectile_amount:
		var projectile = spawn_one(projectile_prefab)
		projectiles.append(projectile)
	
	_add_deviation_step()
	_set_recoil_normalized(recoil_normalized + recoil)
	return projectiles

func spawn_one(projectile_prefab: PackedScene) -> Projectile:
	var projectile:Projectile = ProjectileStorage.request_spawn(projectile_prefab)
	
	projectile.global_position = global_position
	projectile.global_rotation = gun_model.global_rotation
	projectile.global_rotation_degrees += _calculate_spread()
	
	return projectile


func _set_recoil_normalized(value: float):
	recoil_normalized = clampf(value, 0, 1)
	gun_model.rotation_degrees = _calculate_deviation()

func _calculate_deviation() -> float:
	#Take recoil and current deviation sign
	return max_deviation * recoil_normalized * sin(deviation_normalized * PI)

func _add_deviation_step():
	deviation_normalized += step_pi
	
	if deviation_normalized >= 2 || deviation_normalized <= -2:
		deviation_normalized = fmod(deviation_normalized, 2)

func _calculate_spread() -> float:
	return randf_range(-max_spread, max_spread)
