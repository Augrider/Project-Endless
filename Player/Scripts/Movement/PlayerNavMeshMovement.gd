extends NavigationAgent2D

const MAX_SPEED:float=250.0

const DISTANCE_CHECK:float = 1
const DAMPENING:float = 3

@export var body:CharacterBody2D
@export var stopwatch:Stopwatch

@export var maxSpeed:float = 10
@export var accelerationDuration:float = 1
@export var decelerationDuration:float = 1

@export var startCurve:Curve
@export var stopCurve:Curve

var movement_input:Vector2
var moving:bool=false

var speed_relative:float


func _on_input_movement_input_updated(new_value: Vector2) -> void:
	if (new_value.length_squared() > 0) != moving:
		stopwatch.reset()
	
	moving = new_value.length_squared() > 0
	movement_input = new_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	speed_relative = get_relative_speed()
	
	target_position = body.global_position + movement_input * DISTANCE_CHECK
	var next_position = get_next_path_position()
	var direction_unclamped = next_position - body.global_position
	
	if movement_input.dot(direction_unclamped.normalized()) <= 0:
		return
	
	body.set_velocity(speed_relative * maxSpeed * MAX_SPEED * direction_unclamped.limit_length(DAMPENING) / DAMPENING)
	body.move_and_slide()


func get_relative_speed()->float:
	if moving:
		return startCurve.sample(stopwatch.time/accelerationDuration)
	
	return stopCurve.sample(1 - stopwatch.time/decelerationDuration) * speed_relative
