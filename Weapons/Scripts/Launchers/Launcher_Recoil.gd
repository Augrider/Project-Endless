class_name RecoilLauncher extends WeaponLauncher

@export var gun_model: Node2D

var recoil: float = 0.5
var recoil_control: float = 0.5
var max_deviation: float = 10
var max_spread: float = 2

var recoil_normalized: float = 0
var _deviation: float = 0


func _process(delta: float) -> void:
	_set_recoil_normalized(recoil_normalized - recoil_control * delta)


func shoot_once(projectile_prefab: PackedScene, projectile_amount: int = 1) -> Array[Projectile]:
	#Deviation should be based on additional mechanism
	#To shoot waves, a sine function might be used
	var projectiles: Array[Projectile]
	
	for i in projectile_amount:
		var projectile = spawn_one(projectile_prefab)
		projectiles.append(projectile)
	
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
	_deviation = _calculate_deviation()
	gun_model.rotation_degrees = randf_range(0, _deviation)

func _calculate_deviation() -> float:
	#Take recoil and current _deviation sign
	var recoil_sign = signf(_deviation)
	
	if recoil_sign == 0:
		recoil_sign = randi_range(0, 1) * 2 - 1
	
	return max_deviation * recoil_normalized * recoil_sign

func _calculate_spread() -> float:
	return randf_range(-max_spread, max_spread)
