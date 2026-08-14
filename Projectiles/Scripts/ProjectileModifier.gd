##A type of modifier that applies to projectiles at the whole lifecycle
class_name ProjectileModifier extends Resource

@export var power:float=1


func apply(projectile:Projectile)->bool:
	return false
