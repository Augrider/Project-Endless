class_name RecoilGun extends Weapon

#TODO: support for different fire modes

@export var launcher: RecoilLauncher
@export var projectile_prefab: PackedScene

@export var fire_rate: float = 3
@export var projectiles_amount: int = 1
@export var recoil: float = 0.5
@export var recoil_control: float = 0.5
@export var max_deviation: float = 10
@export var max_spread: float = 1

@export var reload_cooldown: float = 1


func _ready() -> void:
	launcher.recoil = recoil
	launcher.recoil_control = recoil_control
	launcher.max_deviation = max_deviation
	launcher.max_spread = max_spread
	
	uses_left = max_uses

func _process(delta: float) -> void:
	if trigger_pressed:
		try_fire()
	
	process_cooldown(delta)


func on_trigger_released() -> void:
	if max_uses > 0 && uses_left < max_uses:
		uses_left = max_uses
		launcher.recoil_normalized = 0
		
		set_cooldown(cooldown + reload_cooldown)


func try_fire()->bool:
	if cooldown > 0 || (max_uses > 0 && uses_left <= 0):
		return false
	
	var projectiles := launcher.shoot_once(projectile_prefab, projectiles_amount)
	for projectile in projectiles:
		projectile.init(Player.ALLEGIANCE)
	
	set_cooldown(1 / fire_rate)
	if uses_left > 0:
		uses_left -= 1
	
	return true
