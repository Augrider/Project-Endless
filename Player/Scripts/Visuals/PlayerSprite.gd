extends AnimatedSprite2D

#TODO: aim, animate, shader effects?

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#


func _on_input_direction_look_point_changed(value: Vector2) -> void:
	flip_h = value.x<0
