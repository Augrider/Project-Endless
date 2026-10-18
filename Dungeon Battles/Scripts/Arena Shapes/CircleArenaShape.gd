class_name CircleArenaShape extends ArenaShape

@export var radius: float = 10


func get_random_point() -> Vector2:
	var random_vector = Vector2(randf_range(-radius,radius), randf_range(-radius,radius))
	return to_global(random_vector.limit_length(radius)) 

func get_center() -> Vector2:
	return global_position

func get_closest(point: Vector2) -> Vector2:
	var limited = to_local(point).limit_length()
	return to_global(limited)
