class_name EnemyGroup

var _enemies: Array[Enemy]


#func _init(enemies:Array[Enemy]) -> void:
	#_enemies = enemies.duplicate()

func append(enemy:Enemy):
	_enemies.append(enemy)
	_clear_unused()

#returns only alive enemies
func get_enemies() -> Array[Enemy]:
	_clear_unused()
	return _enemies

#count of alive enemies
func size() -> int:
	_clear_unused()
	return _enemies.size()

#maybe add some basic commands if convenient


func _clear_unused():
	_enemies = _enemies.filter(_is_valid) as Array[Enemy]

func _is_valid(enemy) -> bool:
	return enemy != null and enemy.health > 0
