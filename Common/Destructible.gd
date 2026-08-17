class_name Destructible extends Area2D

var allegiance:int

@export var max_health: int = 3
var health: int = 3

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


func _ready() -> void:
	health = max_health


func is_allied_with(value:int)->bool:
	return allegiance==value

func apply_damage(value:float)->bool:
	health = clamp(health - value, 0, max_health)
	
	if health == 0:
		get_parent().queue_free()
	return true
