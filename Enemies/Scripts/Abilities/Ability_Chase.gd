class_name ChaseAbility extends EnemyAbility

enum PositioningMode {PLAYER, RANDOM, AWAY}

@export var positioning: PositioningMode

@export var cooldown: float
@export var stop_after_cooldown: bool

@export var stop_distance: float = 0


func perform(arena: Arena):
	active = true
	
	var target_position = _calculate_position(arena)
	
	enemy.go_to_target(target_position)
	
	if stop_distance <= 0:
		await Timers.get_oneshot(cooldown).timeout
	else:
		await _getting_close(target_position, cooldown)
	
	if !active:
		return
	
	if stop_after_cooldown:
		enemy.stop_moving()
	
	active = false

func stop():
	active = false


func _calculate_position(arena: Arena) -> Vector2:
	match positioning:
		PositioningMode.PLAYER: return Players.get_player().global_position
		PositioningMode.RANDOM: return arena.get_random_position()
	
	return Vector2.ZERO

func _getting_close(target: Vector2, cooldown: float):
	var timer = Timers.get_oneshot(cooldown)
	
	while timer.time_left > 0:
		if enemy.global_position.distance_squared_to(target) <= stop_distance * stop_distance:
			enemy.stop_moving()
			break
		
		await get_tree().process_frame
	
	if timer.time_left > 0:
		await timer.timeout
