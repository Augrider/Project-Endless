extends Weapon

@export var launcher:WeaponLauncher
@export var projectile_shield_prefab:PackedScene

var shield_current:Projectile


func _process(delta: float) -> void:
	if !shield_current:
		return
	
	if trigger_pressed:
		shield_current.lifeLeftNormalized = 1
	elif shield_current.power <= 0:
		shield_current = null


func on_trigger_pressed():
	fire()

func on_trigger_released()->void:
	if shield_current:
		shield_current.destroy()


func fire()->void:
	shield_current = launcher.spawn_one(projectile_shield_prefab)
	shield_current.init(0)
