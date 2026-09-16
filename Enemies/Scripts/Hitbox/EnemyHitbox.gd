class_name EnemyHitbox extends UnitHitbox

#@export var max_health: float
#var health: float:
	#set (value):
		#_set_health(value)
	#get:
		#return _health
#
#var _health: float
#
#
#func _ready() -> void:
	#_health = max_health
#

func apply_damage(value: float):
	owner_unit.deal_damage(value)
