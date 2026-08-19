extends Node

signal spawned(enemy:Enemy)
signal despawned(enemy:Enemy)

signal spawn_requested(enemy:Enemy)

var container:EnemyContainer
var container_set:bool = false


func set_container(container:EnemyContainer):
	self.container = container
	container_set = self.container != null

func reset_container():
	self.container = null
	container_set = false

func request_spawn(enemy_prefab:PackedScene) -> Enemy:
	var enemy:Enemy = enemy_prefab.instantiate()
	enemy.global_position = Vector2.ONE*10000
	
	if(container_set):
		container.add_child(enemy)
	
	spawn_requested.emit(enemy)
	return enemy
