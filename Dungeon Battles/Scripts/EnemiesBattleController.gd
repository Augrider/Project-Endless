extends Node2D

#Handle formation reordering and new enemies spawn
#Also provide the list of all enemies to other battle systems

@export var formation: CircleFormation2D

@export var enemy_prefab: PackedScene
@export var spawns_left: int = 10

var player:Player


func _ready() -> void:
	player = Players.get_player()
	
	EnemyStorage.spawned.connect(_on_enemy_spawned)
	EnemyStorage.despawned.connect(_on_enemy_despawned)
	
	while formation.any_spot_available():
		var enemy = _spawn_new(enemy_prefab)
		enemy.global_position = formation.append(enemy)


func _exit_tree() -> void:
	EnemyStorage.spawned.disconnect(_on_enemy_spawned)
	EnemyStorage.despawned.disconnect(_on_enemy_despawned)


func _on_reorder_timer_timeout() -> void:
	formation.reorder()
	
	if !formation.layer_spot_available(formation.layers - 1) || spawns_left <= 0:
		return
	
	await get_tree().create_timer(0.3).timeout
	
	while formation.layer_spot_available(formation.layers - 1) && spawns_left > 0:
		var enemy = _spawn_new(enemy_prefab)
		enemy.global_position = formation.append_to(enemy, formation.get_free_spot(formation.layers - 1))
		spawns_left -= 1


func _on_enemy_spawned(enemy: Enemy):
	pass

func _on_enemy_despawned(enemy: Enemy):
	formation.remove(enemy)
	#Spawn new enemy wave only when outer level is empty
	#Just dont forget to reorder
	#And reorder should also take neighbors of outer level


func _spawn_new(enemy_prefab:PackedScene) -> Enemy:
	var enemy:Enemy = EnemyStorage.request_spawn(enemy_prefab)
	
	enemy.set_allegiance(1)
	enemy.look_at_target(player)
	
	return enemy
