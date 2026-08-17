class_name EnemyContainer extends Node2D

var _enemies: Array[Enemy]
#var _spawn_stack: Array[Enemy]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EnemyStorage.set_container(self)
	
	#EnemyStorage.spawn_requested.connect(_on_spawn_requested)
	EnemyStorage.spawned.connect(_on_enemy_spawned)
	EnemyStorage.despawned.connect(_on_enemy_despawned)

func _exit_tree() -> void:
	EnemyStorage.reset_container()
	
	#EnemyStorage.spawn_requested.disconnect(_on_spawn_requested)
	EnemyStorage.spawned.disconnect(_on_enemy_spawned)
	EnemyStorage.despawned.disconnect(_on_enemy_despawned)

#@warning_ignore("unused_parameter")
#func _process(delta: float) -> void:
	#for enemy in _spawn_stack:
		#add_child(enemy)
	#
	#_spawn_stack.clear()


func _on_enemy_spawned(enemy: Enemy):
	_enemies.append(enemy)
	#_spawn_stack.append(enemy)
	#call_deferred("add_child", enemy)
	#if enemy.get_parent():
		#enemy.get_parent().remove_child(enemy)

func _on_enemy_despawned(enemy: Enemy):
	_enemies.erase(enemy)

#func _on_spawn_requested(enemy:Enemy):
	#add_child(enemy)
