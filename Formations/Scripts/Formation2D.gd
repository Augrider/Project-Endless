@abstract class_name Formation2D extends Node2D

@abstract func any_spot_available()->bool

@abstract func append(enemy:Enemy)->Vector2
@abstract func remove(enemy:Enemy)->void

@abstract func get_enemies()->Array[Enemy]
@abstract func count()->int

@abstract func erase_non_active()
