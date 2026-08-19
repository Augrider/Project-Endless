class_name AlliedNode2D extends Node2D

@export var allegiance:int


func set_allegiance(value:int):
	allegiance = value
	#Change collision mask values

func is_allied_with(allied_node:AlliedNode2D)->bool:
	return allegiance==allied_node.allegiance
