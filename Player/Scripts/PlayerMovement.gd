class_name PlayerMovement extends Node2D

const ACCELERATION_MULTIPLIER:float=100.0
const DECELERATION_MULTIPLIER:float=100.0
const MAX_SPEED:float=250.0

#TODO: Proper speed handling

@export var body:CharacterBody2D
@export var stopwatch:Stopwatch

@export var maxSpeed:float = 10
@export var accelerationDuration:float = 1
@export var decelerationDuration:float = 1

@export var startCurve:Curve
@export var stopCurve:Curve

var movementInput:Vector2
var moving:bool=false

var speedRel:float


func _on_input_movement_input_updated(new_value: Vector2) -> void:
	set_movement_input(new_value)


func set_movement_input(input:Vector2)->void:
	if (input.length_squared() > 0) != moving && stopwatch.time/accelerationDuration > 1:
		stopwatch.reset()
	
	moving=input.length_squared() > 0
	
	if moving:
		movementInput=input


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speedRel = get_relative_speed()

	body.set_velocity(speedRel * maxSpeed * movementInput)
	body.move_and_slide()


func get_relative_speed()->float:
	if moving:
		return startCurve.sample(stopwatch.time/accelerationDuration)
	
	return stopCurve.sample(stopwatch.time/decelerationDuration)*speedRel
