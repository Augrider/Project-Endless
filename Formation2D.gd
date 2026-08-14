@abstract class_name Formation2D extends Node2D

@export var size:int

@abstract
func any_spot_available()->bool
@abstract
func get_spots_available()->Dictionary[Vector2, int]

@abstract
func append(enemy:Enemy)->Vector2
@abstract
func append_to_spot(enemy:Enemy, spot:int)->Vector2

@abstract
func remove(enemy:Enemy)->void

@abstract
func get_enemies()->Array[Enemy]

@abstract
func count()->int
