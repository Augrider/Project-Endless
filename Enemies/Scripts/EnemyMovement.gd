extends NavigationAgent2D

const DRAG:float = 0.6
const BOUNCE:float = 0.3
const STOP_PUSH_THRESHOLD:float = 15

signal pushed(impulse:Vector2)
signal stopped_push

@export var body: CharacterBody2D

@export var speed_multiplier := 1.0
@export var speed := 10.0

var movement_target:Vector2
var follow_target_node:Node2D = null

var impulse:Vector2 = Vector2.ZERO
#func _enter_tree() -> void:
	#stop_moving()


#TODO: Add visibility check to next point of destination
func _physics_process(delta: float) -> void:
	if impulse.length_squared() > 0:
		_process_push(delta)
		return
	
	if body.global_position.distance_squared_to(target_position) < 0.1:
		return
	
	movement_target = get_next_path_position()
	
	#body.look_at(movement_target)
	
	body.velocity = speed * speed_multiplier * (movement_target - body.global_position).limit_length()
	body.move_and_slide()

func _process_push(delta: float):
	#body.look_at(body.global_position - impulse)
	
	var collision = body.move_and_collide(impulse*delta)
	if collision:
		impulse = impulse.bounce(collision.get_normal()) * BOUNCE
	
	impulse -= DRAG * delta * impulse
	if impulse.length_squared() <= STOP_PUSH_THRESHOLD:
		impulse = Vector2.ZERO
		stopped_push.emit()


func _on_repath_timer():
	if follow_target_node != null:
		target_position = follow_target_node.global_position
		return
	
	#target_position = target_position


func follow_target(target: Node2D) -> void:
	follow_target_node = target
	target_position = follow_target_node.global_position

func go_to_target(target: Vector2) -> void:
	follow_target_node = null
	target_position = target

func stop_moving() -> void:
	follow_target_node = null
	target_position = body.global_position


func set_impulse(value:Vector2) -> void:
	print_debug("Impulse "+str(value))
	self.impulse = value
	pushed.emit(value)
