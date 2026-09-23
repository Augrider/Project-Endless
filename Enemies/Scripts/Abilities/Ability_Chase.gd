class_name ChaseAbility extends EnemyAbility

enum PositioningMode {PLAYER, RANDOM, AWAY}

@export var positioning: PositioningMode

@export var cooldown: float
@export var stop_after_cooldown: bool


func perform(arena: Arena):
	active = true
	
	var target_position = _calculate_position(arena)
	
	enemy.go_to_target(target_position)
	
	await get_tree().create_timer(cooldown).timeout
	
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
