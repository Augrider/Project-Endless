extends Node2D

@export var player:Player

@export var enemy_prefab:PackedScene

@export var inner_circle: Formation2D
@export var outer_circle: Formation2D

#@export var cooldown:Timer

var _enemies:Array[Enemy]
var _active_enemies:Array[Enemy]


func spawn_wave() -> void:
	for i in inner_circle.size:
		var enemy:Enemy = enemy_prefab.instantiate()
		
		get_tree().root.add_child(enemy)
		
		enemy.global_position = inner_circle.append_to_spot(enemy, i)
		enemy.look_at_target(player)
		
		_enemies.append(enemy)
		_active_enemies.append(enemy)
	
	for i in outer_circle.size:
		var enemy:Enemy = enemy_prefab.instantiate()
		
		get_tree().root.add_child(enemy)
		
		enemy.global_position = outer_circle.append_to_spot(enemy, i)
		enemy.look_at_target(player)
		
		_enemies.append(enemy)


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
