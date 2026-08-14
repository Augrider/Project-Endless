class_name CircleFormation2D extends Formation2D

@export var radius:float = 30.0
@export var offset:float = 0
var _enemies: Dictionary[int, Enemy]


func any_spot_available()->bool:
	for i in size:
		if !_enemies.has(i):
			return true
	return false

func get_spots_available()->Dictionary[Vector2, int]:
	var dict:Dictionary[Vector2, int]
	for i in size:
		if !_enemies.has(i):
			dict.set(get_spot(i), i)
	return dict

func get_spot(index:int)->Vector2:
	return Vector2.UP.rotated(2*PI*(index+offset)/size)*radius


func append(enemy:Enemy)->Vector2:
	for i in size:
		if !_enemies.has(i):
			_enemies.set(i, enemy)
			return get_spot(i)
	return Vector2.ZERO

func append_to_spot(enemy:Enemy, spot:int)->Vector2:
	_enemies.set(spot, enemy)
	return get_spot(spot)

func remove(enemy:Enemy)->void:
	var key = -1
	for i in _enemies:
		if _enemies[i] == enemy:
			key = i
			break
	
	if key > 0:
		_enemies.erase(key)


func get_enemies()->Array[Enemy]:
	return _enemies.values()

func count()->int:
	return _enemies.size()
