extends NavigationAgent2D

@export var body: CharacterBody2D

@export var speed_multiplier := 1.0
@export var speed := 10.0

var movement_target:Vector2
var follow_target_node:Node2D = null

#func _enter_tree() -> void:
	#stop_moving()


#TODO: Add visibility check to next point of destination
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if body.global_position.distance_squared_to(target_position) < 0.1:
		return
	
	movement_target = get_next_path_position()
	
	body.look_at(movement_target)
	
	body.velocity = speed * speed_multiplier * (movement_target - body.global_position).limit_length()
	body.move_and_slide()


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
