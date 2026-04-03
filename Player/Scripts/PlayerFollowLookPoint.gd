extends Node2D

var currentTween:Tween

#@export var 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func turn_to_point():
	pass


func get_target_angle(point:Vector2)->float:
	return get_angle_to(point)

func RotateTowards(target_angle:float)->void:
	if currentTween != null:
		currentTween.kill()
		currentTween = null
	
	currentTween = get_tree().create_tween()
	currentTween.tween_property(self, "rotation", rotation, target_angle)
	currentTween.tween_property($Sprite, "scale", Vector2(), 1.0)
	currentTween.tween_callback($Sprite.queue_free)
