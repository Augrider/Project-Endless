extends Node

@export var owner_projectile:Projectile


func _on_opponent_projectile_hit(projectile: Projectile) -> void:
	#change projectile allegiance
	projectile.set_allegiance(owner_projectile.allegiance)
	#first, reverse the direction
	#then, based on small random, random direction and power of both projectiles
	#rotate the direction
	projectile.global_rotation_degrees = _get_projectile_direction(projectile)
	#And add some velocity and power
	projectile.add_power(owner_projectile.power)
	#And reduce our own
	owner_projectile.reduce_power(1)

func _get_projectile_direction(projectile:Projectile):
	var target_rotation:float = owner_projectile.global_rotation_degrees
	var change_direction: int = 1 if randi() % 2 > 0 else -1
	target_rotation += randf_range(-5, 5)
	
	if projectile.power > owner_projectile.power:
		var angle: float = clamp(projectile.power-owner_projectile.power, 0, 10.0)*12.0
		target_rotation += change_direction * angle
	
	return target_rotation
