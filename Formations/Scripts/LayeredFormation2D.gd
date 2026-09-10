@abstract class_name LayeredFormation2D extends Formation2D

@export var layers:int = 3

@export var inner_enemies_count:int = 4
#@export var layer_enemies_delta:int = 0

@abstract func reorder()

@abstract func layer_spot_available(layer:int) -> bool
@abstract func get_free_layer_spot(layer: int) -> Vector2i

@abstract func append_to(enemy: Enemy, spot: Vector2i) -> Vector2

@abstract func get_inner_enemies()->Array[Enemy]

@abstract func count_on_layer(layer:int) -> int
