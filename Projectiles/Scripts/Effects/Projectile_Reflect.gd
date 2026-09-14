extends ProjectileComponent

@export var boost_multiplier: float = 1.1
@export var reflect_cost: float


func _on_opponent_projectile_hit(projectile: Projectile) -> void:
	#change projectile allegiance
	#first, reverse the direction
	#then, based on small random, random direction and power of both projectiles
	#rotate the direction
	#And add some velocity and power
	
	projectile.global_rotation_degrees = _get_reflect_direction(projectile)
	
	projectile.set_allegiance(owner_projectile.allegiance)
	projectile.set_power(projectile.power * boost_multiplier)
	projectile.speed *= boost_multiplier
	
	owner_projectile.add_power(-reflect_cost)


func _get_reflect_direction(projectile:Projectile):
	var target_rotation:float = owner_projectile.global_rotation_degrees
	var delta: float = randf_range(-10, 10)
	
	if projectile.power > owner_projectile.power:
		var angle: float = clamp(projectile.power - owner_projectile.power, 0, 10.0)*6.0
		delta += angle * sign(delta)
	
	target_rotation += delta
	return target_rotation
