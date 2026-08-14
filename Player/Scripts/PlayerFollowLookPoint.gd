extends Node2D

@export var _duration_multiplier:float

var _current_point: Vector2


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var angle_delta = _get_target_delta(_current_point)
	rotate(angle_delta * _duration_multiplier)


func aim_at(value:Vector2) -> void:
	_current_point = value

func get_direction() -> Vector2:
	return global_transform.x


func _get_target_delta(point:Vector2)->float:
	var delta = get_angle_to(point)
	
	return delta
