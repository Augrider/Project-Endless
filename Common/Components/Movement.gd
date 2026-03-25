class_name Movement extends Node

var speed:Vector2
var acceleration:Vector2


func get_velocity()->Vector2:
	return speed

func get_acceleration()->Vector2:
	return acceleration


func set_velocity(value:Vector2)->void:
	speed=value

func set_acceleration(value:Vector2)->void:
	acceleration=value


func add_impulse(value:Vector2)->void:
	speed+=value
