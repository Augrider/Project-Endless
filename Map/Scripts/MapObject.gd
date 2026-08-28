#Static object on the map
class_name MapObject extends Node2D

@export var size:Vector2i = Vector2i.ONE


func get_size_rect(cell:Vector2i) -> Rect2i:
	return Rect2i(cell, size)

func calculate_rect(map: TileMapLayer) -> Rect2i:
	var local_position = map.to_local(global_position)
	var cell = map.local_to_map(local_position)
	
	return Rect2i(cell, size)
