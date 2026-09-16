class_name PlayerHealth extends UnitHitbox

# Handle immunity time and basic health storage
@export var owner_player: Player

@export var max_health: int
var health: int:
	set (value):
		_set_health(value)
	get:
		return _health

var _health: int


func _ready() -> void:
	_health = max_health


func is_allied_with(allied_node:AlliedNode2D)->bool:
	return owner_player.allegiance == allied_node.allegiance

func apply_damage(value: float):
	#If not invulnerable - remove one health
	#Otherwise, just return
	pass


func _set_health(value: int):
	_health = value
