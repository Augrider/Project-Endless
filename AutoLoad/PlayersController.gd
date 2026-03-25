extends Node

#access to player
#access to player stats and state
#save/load?
#get/set start presets, weapons

var player:Player


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.
	

func get_player()->Player:
	return player
	
func add_player(value:Player)->void:
	player=value
	
func remove_player(value:Player)->void:
	player=null
