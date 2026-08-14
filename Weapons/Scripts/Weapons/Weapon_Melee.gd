extends Weapon

@export var launcher:WeaponLauncher
@export var melee:Launcher_Melee

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
	
	print_debug("Firing!")
	fire()
	
	cooldown=1/fire_rate
	return true


func fire()->void:
	#If something in front of hitbox - perform clash and return
	#Shoot projectile and enable blade
	#If something collided with blade (works as a projectile) - deal damage
	#return
	#Projectile modifiers applied only to shot
	melee.perform(1/fire_rate)
	
	var projectiles:Array[Projectile]=launcher.spawn(projectile_prefab, 1)

	for projectile in projectiles:
		projectile.init()
