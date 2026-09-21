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

@export var mag_size: int = 10
@export var reload_cooldown: float = 1

var cooldown: float = 0
var mag_ammo: int


func _ready() -> void:
	launcher.recoil = recoil
	launcher.recoil_control = recoil_control
	launcher.max_deviation = max_deviation
	launcher.max_spread = max_spread
	
	mag_ammo = mag_size

func _process(delta: float) -> void:
	if trigger_pressed:
		try_fire()
	
	if cooldown > 0:
		cooldown = clamp(cooldown - delta, 0, cooldown)


func on_trigger_released() -> void:
	if mag_ammo < mag_size:
		mag_ammo = mag_size
		#launcher.recoil_normalized = 0
		
		cooldown += reload_cooldown


func try_fire()->bool:
	if cooldown > 0 || mag_ammo <= 0:
		return false
	
	var projectiles := launcher.shoot_once(projectile_prefab, projectiles_amount)
	for projectile in projectiles:
		projectile.init(Player.ALLEGIANCE)
	
	cooldown = 1/fire_rate
	mag_ammo -= 1
	return true
