extends EnemyAbility

@export var projectile_prefab: PackedScene
@export var shot_count: int = 3
@export var fire_rate: float = 1
@export var cooldown: float = 0.5


func perform(enemy:Enemy):
	active = true
	
	var player = Players.get_player()
	
	await get_tree().create_timer(0.3 * randf()).timeout
	
	for i in shot_count:
		if !active:
			return
		
		%Launcher.look_at(player.global_position)
		
		var projectile = %Launcher.spawn_one(projectile_prefab)
		projectile.init(enemy.allegiance)
		
		await get_tree().create_timer(1/(fire_rate * enemy.intensity)).timeout
	
	await get_tree().create_timer(cooldown).timeout
	active = false

func stop():
	active = false
