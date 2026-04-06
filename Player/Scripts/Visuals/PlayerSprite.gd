extends AnimatedSprite2D

#TODO: aim, animate, shader effects?

var currentPoint:Vector2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	flip_h = (currentPoint.x - global_position.x) < 0


func _on_input_direction_look_point_changed(value: Vector2) -> void:
	currentPoint = value
