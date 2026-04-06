extends Node2D

@export var durationMultiplier:float

var currentTween:Tween
var currentPoint:Vector2

#@export var 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var target = get_target_angle(currentPoint)
	rotate_towards_angle(target)


func _on_input_direction_look_point_changed(value: Vector2) -> void:
	currentPoint = value


func get_target_angle(point:Vector2)->float:
	return global_rotation + get_angle_to(point)

func get_target_delta(point:Vector2)->float:
	var target = get_target_angle(point)
	var current = global_rotation
	var delta = target-current
	
	if delta<=PI:
		return delta
	else:
		return delta - 2*PI

func rotate_towards_angle(target_angle:float)->void:
	if currentTween != null:
		currentTween.kill()
		currentTween = null
	
	currentTween = get_tree().create_tween()
	var duration = (target_angle-global_rotation)*durationMultiplier
	currentTween.tween_property(self, "global_rotation", target_angle, duration)
