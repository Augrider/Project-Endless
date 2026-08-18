class_name CircleFormation2D extends Formation2D

@export var radius:float = 30.0
@export var offset:float = 0
var _enemies: Dictionary[int, Enemy]


func any_spot_available()->bool:
	for i in size:
		if !_enemies.has(i):
			return true
	return false

func get_spots_available()->Array[int]:
	var result:Array[int]
	
	for i in size:
		if !_enemies.has(i):
			result.append(i)
	
	return result


func get_spot(index:int)->Vector2:
	return Vector2.UP.rotated(2*PI*(index+offset)/size)*radius

func get_closest(position:Vector2)->int:
	var closest = get_spot(0)
	var closest_spot = 0
	var distance = closest.distance_squared_to(position)
	var current_distance:float
	
	for i in size:
		current_distance = closest.distance_squared_to(get_spot(i))
		if current_distance < closest:
			closest = current_distance
			closest_spot = i
	
	return closest_spot


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


func get_spot_of(enemy:Enemy)->int:
	var key = -1
	
	for i in _enemies:
		if _enemies[i] == enemy:
			key = i
			break
	
	return key

func get_enemies()->Array[Enemy]:
	return _enemies.values()

func get_enemy(spot:int)->Enemy:
	if _enemies.has(spot):
		return _enemies[spot]
	
	return null


func count()->int:
	return _enemies.size()
