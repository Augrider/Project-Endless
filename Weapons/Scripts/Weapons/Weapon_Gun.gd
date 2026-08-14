extends Weapon

#nothing unusual, just shoot projectiles
#TODO: support for different fire modes
@export var launcher:WeaponLauncher

@export var projectile_prefab:PackedScene

@export var fire_rate:float = 3


func _process(delta: float) -> void:
	if triggerPressed:
		try_fire()
	
	if cooldown > 0:
		cooldown=clamp(cooldown-delta, 0, cooldown)


func try_fire()->bool:
	if(cooldown > 0):
		return false
	
	fire()
	
	cooldown=1/fire_rate
	return true


func fire()->void:
	var projectiles:Array[Projectile]=launcher.spawn(projectile_prefab, 1)

	for projectile in projectiles:
		projectile.init()
