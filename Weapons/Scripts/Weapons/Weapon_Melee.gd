class_name MeleeWeapon extends Weapon

@export var launcher_projectile: WeaponLauncher
@export var launcher_melee: WeaponLauncher

@export var projectile_prefab: PackedScene
@export var projectile_melee_prefab: PackedScene

@export var fire_rate:float = 3


func _process(delta: float) -> void:
	if trigger_pressed:
		try_fire()
	
	process_cooldown(delta)


func try_fire()->bool:
	if(cooldown > 0):
		return false
	
	fire()
	
	set_cooldown(1 / fire_rate)
	return true


func fire()->void:
	var projectile := launcher_projectile.spawn_one(projectile_prefab)
	var projectile_melee := launcher_melee.spawn_one(projectile_melee_prefab)
	
	projectile.init(0)
	projectile_melee.init(0)
