extends Node

@export var owner_projectile:Projectile


func _on_opponent_projectile_hit(projectile: Projectile) -> void:
	#first, reverse the direction
	#then, based on small random, random direction and power of both projectiles
	#rotate the direction
	projectile.global_rotation_degrees = _get_projectile_direction(projectile)
	projectile.set_power(projectile.power * 0.8)
	projectile.speed *= 0.7
	projectile.lifeLeftNormalized * 0.6

	#And reduce our own (in addition to projectile hit itself)
	owner_projectile.add_power(-1)

func _get_projectile_direction(projectile:Projectile):
	var target_rotation: float = owner_projectile.global_rotation_degrees
	var delta: float = randf_range(-45, 45)
	
	var power_left: float = owner_projectile.power/owner_projectile.base_power
	
	if power_left < 1:
		var angle: float = (1 - power_left) * 135.0
		delta += angle * sign(delta)
	
	target_rotation += delta
	return target_rotation
