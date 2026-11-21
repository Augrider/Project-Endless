extends Node2D

#Handle formation reordering and new enemies spawn
#Also provide the list of all enemies to other battle systems

@export var formation: LayeredFormation2D

@export var enemies: EncounterEnemies
var enemies_left: Dictionary[PackedScene, int]

var player:Player


func _ready() -> void:
	player = Players.get_player()
	
	EnemyStorage.spawned.connect(_on_enemy_spawned)
	EnemyStorage.despawned.connect(_on_enemy_despawned)
	
	enemies_left[enemies.base_enemy_prefab] = enemies.base_enemy_amount
	
	for enemy in enemies.elite_enemies:
		enemies_left[enemy] = enemies.elite_enemies[enemy]
	
	_spawn_at_free_places()



func _exit_tree() -> void:
	EnemyStorage.spawned.disconnect(_on_enemy_spawned)
	EnemyStorage.despawned.disconnect(_on_enemy_despawned)


func _on_reorder_timer_timeout() -> void:
	formation.reorder()
	
	await get_tree().create_timer(0.3).timeout
	
	if !formation.layer_spot_available(formation.layers - 1):
		return
	
	_spawn_at_last_layer()


func _on_enemy_spawned(enemy: Enemy):
	pass

func _on_enemy_despawned(enemy: Enemy):
	pass
	#Spawn new enemy wave only when outer level is empty
	#And reorder should also take neighbors of outer level


func _spawn_new(enemy_prefab:PackedScene) -> Enemy:
	var enemy:Enemy = EnemyStorage.request_spawn(enemy_prefab)
	
	enemy.set_allegiance(1)
	enemy.look_at_target(player)
	
	return enemy


func _spawn_at_free_places() -> void:
	while formation.any_spot_available() && enemies_left.size() > 0:
		#decide which enemy to spawn
		var index = randi_range(0, enemies_left.size() - 1)
		var prefab: PackedScene = enemies_left.keys()[index]
		
		var enemy = _spawn_new(prefab)
		enemy.global_position = formation.append(enemy)
		
		enemies_left[prefab] -= 1
		if enemies_left[prefab] <= 0:
			enemies_left.erase(prefab)

func _spawn_at_last_layer() -> void:
	var last_layer = formation.layers-1
	while formation.layer_spot_available(last_layer) && enemies_left.size() > 0:
		#decide which enemy to spawn
		var index = randi_range(0, enemies_left.size() - 1)
		var prefab: PackedScene = enemies_left.keys()[index]
		var spot = formation.get_free_layer_spot(last_layer)
		
		var enemy = _spawn_new(prefab)
		enemy.global_position = formation.append_to(enemy, spot)
		
		enemies_left[prefab] -= 1
		if enemies_left[prefab] <= 0:
			enemies_left.erase(prefab)
