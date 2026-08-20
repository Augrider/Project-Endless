class_name Player extends Unit

# Handles input from top, health, weapons, movement...
# Does Godot allow good separation?

#export(NodePath) var inputPath
#var input:PlayerInput

#export(NodePath) var movementPath
#var movement:PlayerMovement


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Players.add_player(self)
	
#	movement=get_node(movementPath)

func _exit_tree() -> void:
	Players.remove_player(self)

func deal_damage(value:float):
	pass

func set_pushed(impulse:Vector2):
	pass

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	speed=movement.speed
#	acceleration=movement.acceleration


# save/load player state and stats
# 
