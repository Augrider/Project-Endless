extends Node2D

@export var player:Player

@export var enemy_prefab:PackedScene
@export var radius:float = 30.0
@export var rings:int = 2
@export var ring_enemy_count:int


#@export var cooldown:Timer

var _enemies:Array[Enemy]
var _active_enemies:Array[Enemy]


func spawn_wave() -> void:
	for ring in rings:
		for i in ring_enemy_count+ring:
			var enemy:Enemy = enemy_prefab.instantiate()
			
			get_tree().root.add_child(enemy)
			
			enemy.global_position = get_circle_position(i, ring)
			enemy.look_at_target(player)
			
			_enemies.append(enemy)
			if ring == 0:
				_active_enemies.append(enemy)


func _on_spawn_timer() -> void:
	#print_debug("Sending units")
	spawn_wave()
	
	#for enemy:Enemy in _enemies:
		#enemy.go_to_target(player.global_position)

func _on_wave_attack_timer() -> void:
	for enemy in _active_enemies:
		enemy.stop_moving()
		enemy.perform_ability(player)
		await get_tree().create_timer(0.2).timeout
	
	_active_enemies.shuffle()
	var enemy = _active_enemies[0]
	enemy.follow_target(player)
	await get_tree().create_timer(1).timeout
	
	for i in randi() % 6 + 1:
		enemy.perform_ability(player)
		await get_tree().create_timer(0.4).timeout


func get_circle_position(index:int, ring:int)->Vector2:
	return Vector2.UP.rotated(2*PI*(index+0.5*ring)/(ring_enemy_count+ring))*(radius+5*ring)
