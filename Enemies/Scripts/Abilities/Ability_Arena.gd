class_name ArenaAbility extends EnemyAbility

@export var projectile_prefab: PackedScene
@export var shot_count: int = 3
@export var spread_variance: float = 3

@export var fire_rate: float = 1
@export var cooldown: float = 0.5


func perform(arena: Arena):
	active = true
	
	var player = Players.get_player()
	
	await get_tree().create_timer(0.3 * randf()).timeout
	
	for i in shot_count:
		if !active:
			return
		
		var target = arena.get_current_target()
		var spread: float = _calculate_spread()

		%Launcher.look_at(target)
		var projectile = %Launcher.spawn_one(projectile_prefab)
		
		projectile.rotation_degrees += spread
		projectile.init(enemy.allegiance)
		
		await get_tree().create_timer(1/(fire_rate * enemy.intensity)).timeout
	
	await get_tree().create_timer(cooldown).timeout
	active = false

func stop():
	active = false


func _calculate_spread() -> float:
	return randf_range(-spread_variance, spread_variance)
