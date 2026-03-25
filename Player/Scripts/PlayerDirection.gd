class_name PlayerDirection extends Node
#TODO: Add proper hands class and add limits
#TODO: Draw weapons with hands as one sprite, or do that only with some weapons
@export var nodePath: NodePath
@onready var body:Node2D = get_node(nodePath)

@export var camPath: NodePath
@onready var cam:Camera2D=get_node(camPath)

@export var rotationSpeed:float


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#StepRotateTowards(get_target_angle(), delta)
	

func get_target_angle()->float:
	return body.get_angle_to(cam.get_global_mouse_position())

func StepRotateTowards(targetAngle:float, delta:float)->void:
	var speed = rotationSpeed*delta
	var rotation = clamp(targetAngle, -speed, speed)
	
#	// Smoothly rotate towards the target angle
	body.rotate(rotation)
