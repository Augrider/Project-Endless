extends EnemyAbility

@export var projectile_prefab: PackedScene
@export var fire_rate: float = 1


func perform(enemy:Enemy):
	active = true
	
	var player = Players.get_player()
	enemy.follow_target(player)
	
	while active:
		%Launcher.look_at(player.global_position)
		
		var projectile = %Launcher.spawn_one(projectile_prefab)
		projectile.init(enemy.allegiance)
		
		await get_tree().create_timer(1/(fire_rate * enemy.intensity)).timeout
	
	enemy.stop_moving()
	active = false

func stop():
	active = false
