extends Node2D

@export var player:Player

@export var enemy_prefab:PackedScene

@export var inner_circle: Formation2D
@export var outer_circle: Formation2D

#@export var cooldown:Timer

var _enemies:Array[Enemy]
#var _active_enemies:Array[Enemy]


func _ready() -> void:
	EnemyStorage.despawned.connect(_on_enemy_despawned)


func spawn_wave() -> void:
	for i in inner_circle.size:
		var enemy:Enemy = EnemyStorage.request_spawn(enemy_prefab)
		
		enemy.global_position = inner_circle.append_to_spot(enemy, i)
		enemy.look_at_target(player)
		
		_enemies.append(enemy)
		#_active_enemies.append(enemy)
	
	for i in outer_circle.size:
		var enemy:Enemy = EnemyStorage.request_spawn(enemy_prefab)

		enemy.global_position = outer_circle.append_to_spot(enemy, i)
		enemy.look_at_target(player)
		
		_enemies.append(enemy)


func _on_spawn_timer() -> void:
	#print_debug("Sending units")
	spawn_wave()
	
	#for enemy:Enemy in _enemies:
		#enemy.go_to_target(player.global_position)


func _on_enemy_despawned(enemy:Enemy):
	_enemies.erase(enemy)
	var active_enemies := inner_circle.get_enemies()
	var outer_enemies := outer_circle.get_enemies()
	
	# enemy is not in active - do nothing for now
	if !active_enemies.has(enemy):
		return
	
	var spot = inner_circle.get_spot_of(enemy)
	
	inner_circle.remove(enemy)
	var new_enemy := _get_closest(enemy, outer_enemies)
	
	if new_enemy == enemy:
		return
	
	outer_circle.remove(new_enemy)
	var position = inner_circle.append_to_spot(new_enemy, spot)
	
	new_enemy.go_to_target(position)
	
	#Spawn new at the end

func _on_wave_attack_timer() -> void:
	var _active_enemies := inner_circle.get_enemies()
	for enemy in _active_enemies:
		if enemy == null:
			continue
		
		enemy.stop_moving()
		enemy.perform_ability(player)
		await get_tree().create_timer(0.2).timeout
	
	_active_enemies.shuffle()
	var enemy = _active_enemies[0]
	
	if enemy == null:
		return

	enemy.follow_target(player)
	await get_tree().create_timer(1).timeout
	
	for i in randi() % 6 + 5:
		enemy.perform_ability(player)
		await get_tree().create_timer(0.4).timeout


func _get_closest(target:Enemy, candidates:Array[Enemy])->Enemy:
	if candidates.size()<=0:
		return target
	
	var dis = target.position.distance_squared_to(candidates[0].position)
	var closest = candidates[0]
	
	var temp_dis
	
	for n in candidates:
		temp_dis = target.position.distance_squared_to(n.position)
		if temp_dis < dis:
			dis = temp_dis
			closest = n
	
	return closest
