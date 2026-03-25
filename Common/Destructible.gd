class_name Destructible extends Area2D

var allegiance:int

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func is_allied_with(value:int)->bool:
	return allegiance==value

func apply_damage(value:float)->bool:
	return false
