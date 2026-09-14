@abstract class_name Projectile extends AlliedNode2D

var power: float
var speed: float
var lifetime: float

var lifeLeftNormalized: float = 1

var active: bool = false

var _power_delta: float = 0


func init(allegiance:int)->void:
	active = true
	
	lifeLeftNormalized = 1
	set_allegiance(allegiance)
	
	on_init()

func _process(delta: float) -> void:
	if !active:
		return
	
	lifeLeftNormalized -= delta/lifetime
	
	if lifeLeftNormalized <= 0 || power <= 0:
		destroy()
		return
	
	if _power_delta != 0:
		on_power_changed(_power_delta)
		_power_delta = 0
	
	on_process(delta)


func on_process(delta: float) -> void:
	pass


func add_power(value: float) -> void:
	_power_delta += value

func set_power(value: float) -> void:
	_power_delta = value - power

@abstract func on_power_changed(delta: float)
@abstract func call_collision_with(projectile: Projectile)

@abstract func on_init() -> void
@abstract func destroy() -> void
