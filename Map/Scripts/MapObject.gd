#Static object on the map, can at least try to receive damage
class_name MapObject extends AlliedNode2D

signal damage_received(value:float)

@export var cell_size:Vector2i = Vector2i.ONE


func get_size_rect(cell:Vector2i) -> Rect2i:
	return Rect2i(cell, cell_size)

func calculate_rect(map: TileMapLayer) -> Rect2i:
	var local_position = map.to_local(global_position)
	var cell = map.local_to_map(local_position)
	
	return Rect2i(cell, cell_size)


func apply_damage(value:float):
	damage_received.emit(value)
