extends NavigationAgent2D

const MAX_SPEED:float=250.0

const DISTANCE_CHECK:float = 1
const DAMPENING:float = 3

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
func _physics_process(delta: float) -> void:
	speedRel = get_relative_speed()
	
	target_position = body.global_position + (movementInput) * DISTANCE_CHECK
	var next_position = get_next_path_position()
	var direction_unclamped = next_position - body.global_position
	
	if movementInput.dot(direction_unclamped.normalized()) <= 0:
		return
	
	body.set_velocity(speedRel * maxSpeed * direction_unclamped.limit_length(DAMPENING) / DAMPENING)
	body.move_and_slide()


func get_relative_speed()->float:
	if moving:
		return startCurve.sample(stopwatch.time/accelerationDuration)
	
	return stopCurve.sample(stopwatch.time/decelerationDuration)*speedRel
