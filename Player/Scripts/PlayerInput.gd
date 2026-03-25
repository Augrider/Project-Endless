class_name PlayerInput extends Node

signal movement_input_updated

@export var movementInput:Vector2
@export var boostInput:bool=false
@export var stopInput:bool=false

@export var movementPath: NodePath

var movement:PlayerMovement

#TODO: Add ability to turn on and off
#TODO: Find how to pause

func _ready() -> void:
	movement = get_node(movementPath)

func _process(delta:float)->void:
	movementInput = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	boostInput = Input.get_action_strength("boost")
	stopInput = Input.get_action_strength("stop")
	
	if movementInput != self.movementInput:
			self.movementInput = movementInput
			emit_signal("movement_input_updated")
			#print_debug("Movement changed "+String(movementInput))
			
	movement.set_movement_input(movementInput.normalized())
