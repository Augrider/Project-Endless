class_name Arena extends Node2D

@export var formation: LayeredFormation2D
var chasers: Array[Enemy]


func _ready() -> void:
	EnemyStorage.despawned.connect(_on_enemy_despawned)

func _exit_tree() -> void:
	EnemyStorage.despawned.disconnect(_on_enemy_despawned)


func _on_enemy_despawned(enemy: Enemy):
	formation.remove(enemy)
	chasers.erase(enemy)


#Get current arena position for targeting. Periodically rotates
func get_current_target() -> Vector2:
	return global_position

func get_random_position() -> Vector2:
	return global_position
