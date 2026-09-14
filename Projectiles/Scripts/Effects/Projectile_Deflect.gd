extends ProjectileComponent

@export var deflect_multiplier: float = 0.9
@export var deflect_cost: float


func _on_opponent_projectile_hit(projectile: Projectile) -> void:
	#first, reverse the direction
	#then, based on small random, random direction and power of both projectiles
	#rotate the direction
	projectile.global_rotation_degrees = _get_deflect_direction(projectile)
	
	projectile.set_power(projectile.power * deflect_multiplier)
	projectile.speed *= deflect_multiplier
	projectile.lifeLeftNormalized *= deflect_multiplier

	owner_projectile.add_power(-deflect_cost)


func _get_deflect_direction(projectile:Projectile):
	var target_rotation: float = owner_projectile.global_rotation_degrees
	var delta: float = randf_range(-45, 45)
	
	var relative_strength: float = owner_projectile.power / owner_projectile.base_power
	
	if relative_strength < 1:
		var angle: float = (1 - relative_strength) * 135.0
		delta += angle * sign(0.5 - randf())
	
	target_rotation += delta
	return target_rotation
