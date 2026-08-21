extends Node2D

@export var top:Sprite2D
@export var bottom:Sprite2D

@export var body:CharacterBody2D

@export var _rotation_multiplier:float = 1.0

var _is_looking: bool = false

var _look_target: Node2D
var _look_position: Vector2


func _process(delta: float) -> void:
	_process_look(delta)
	_process_rotation(delta)


func look_at_target(target:Node2D):
	_is_looking=true
	_look_target=target

func look_at_position(position:Vector2):
	_is_looking=true
	_look_position=position

func stop_looking():
	_is_looking=false
	rotation=0


func _process_look(delta: float):
	if !_is_looking:
		global_rotation = 0
		return
	
	if _look_target != null:
		_look_position = _look_target.position
	
	var angle_delta = _get_target_delta(top, _look_position)
	top.rotate(angle_delta * _rotation_multiplier * delta)


func _process_rotation(delta: float):
	if body.velocity.length_squared() > 0:
		var angle_delta = _get_target_delta(bottom, global_position + body.velocity)
		bottom.rotate(angle_delta * _rotation_multiplier * delta)


func _get_target_delta(node2D:Node2D, point:Vector2)->float:
	return node2D.get_angle_to(point)
