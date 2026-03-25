class_name SpaceObject extends Node2D

var allegiance:int
# Performs physics of object in space

@export var movementPath:NodePath
var movement:Movement


func is_allied_with(value:int)->bool:
	return allegiance==value


##Get movement component. Null if no such component attached to object
func get_movement_or_null()->Movement:
	if movement==null:
		movement = get_node_or_null(movementPath)
	
	return movement
