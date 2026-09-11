extends EnemyAbility

@export var projectile_prefab: PackedScene
@export var fire_rate: float = 1

func _process(delta: float) -> void:
	if durationLeft > 0:
		durationLeft = clamp(durationLeft - delta, 0, durationLeft)

func perform(enemy:Enemy, duration:float, intensity:float = 1):
	durationLeft = duration
	self.intensity = intensity
	
	var player = Players.get_player()
	
	while durationLeft > 0:
		enemy.follow_target(player)
		
		%Launcher.look_at(player.global_position)
		
		var projectile = %Launcher.spawn_one(projectile_prefab)
		projectile.init(enemy.allegiance)
		
		await get_tree().create_timer(1/(fire_rate*self.intensity)).timeout
