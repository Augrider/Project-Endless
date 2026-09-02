class_name CircleFormation2D extends Formation2D

@export var layers:int = 3

@export var inner_enemies_count:int = 4
#@export var layer_enemies_delta:int = 0

@export var inner_radius:float = 30.0
#@export var layer_offset:float = 0
@export var layer_radius_delta:float = 10.0

#Position inside layer is Vector2i:
#x - layer
#y - position from top
var _enemies: Dictionary[Vector2i, Enemy]

var _max_enemies_count:int


func _ready() -> void:
	_max_enemies_count = inner_enemies_count * layers
#When adding unit - place it at last available slot

#Works with at least 2 layers
func reorder():
	print_debug("Reordering")
	_erase_non_active()
	
	for layer in range(0, layers - 1):
		var index = _get_layer_free_spot(layer)
		
		while index != -1:
			var spot = Vector2i(layer, index)
			var from = Vector2i(layer+1, index)
			
			#Move enemy in front
			if _enemies.has(from):
				_move_enemy_to(_enemies[from], spot, from)
				index = _get_layer_free_spot(layer)
			else:
				index = -1
			#TODO: Check other 2 next to it 
 

func any_spot_available() -> bool:
	_erase_non_active()
	return _enemies.size() < _max_enemies_count

func layer_spot_available(layer:int) -> bool:
	_erase_non_active()
	return _get_layer_free_spot(layer) != -1


func append(enemy:Enemy) -> Vector2:
	var spot: Vector2i = -Vector2i.ONE
	
	_erase_non_active()
	
	if _enemies.values().has(enemy):
		spot = _get_enemy_spot(enemy)
	else:
		for layer in range(layers - 1, -1, -1):
			var index = _get_layer_free_spot(layer)
			
			if index >= 0:
				spot = Vector2i(layer, index)
				break
	
	if spot.x >= 0:
		_enemies[spot] = enemy
	
	var target = _get_spot_position(spot)
	
	enemy.go_to_target(target)
	return target


func remove(enemy:Enemy)->void:
	var spot = _get_enemy_spot(enemy)
	
	if spot != -Vector2i.ONE:
		_enemies.erase(spot)


func get_enemies()->Array[Enemy]:
	_erase_non_active()
	return _enemies.values()

func get_inner_enemies()->Array[Enemy]:
	_erase_non_active()
	var enemies: Array[Enemy]
	
	for spot in _enemies:
		if spot.x == 0:
			enemies.append(_enemies[spot])
	
	return enemies


func count()->int:
	return _enemies.size()

func layer_count(layer:int) -> int:
	var count = 0
	
	for spot in _enemies:
		if spot.x == layer:
			count += 1
	
	return count


func _get_layer_size(layer:int) -> int:
	return inner_enemies_count

func _get_spot_position(spot:Vector2i) -> Vector2:
	if spot.x < 0:
		return Vector2.ZERO
	
	return Vector2.UP.rotated(2 * PI * spot.y / inner_enemies_count)*(inner_radius + spot.x * layer_radius_delta)

func _get_layer_free_spot(layer:int) -> int:
	for i in range(0, _get_layer_size(layer)):
		if !_enemies.has(Vector2i(layer, i)):
			return i
	
	return -1

func _get_enemy_spot(enemy:Enemy) -> Vector2i:
	for spot in _enemies:
		if _enemies[spot] == enemy:
			return spot
	
	return -Vector2i.ONE

func _move_enemy_to(enemy:Enemy, spot:Vector2i, from:Vector2i = -Vector2i.ONE):
	_enemies[spot] = enemy
	
	enemy.go_to_target(_get_spot_position(spot))
	
	if from != -Vector2i.ONE:
		_enemies.erase(from)

func _erase_non_active():
	for spot in _enemies.keys():
		if _enemies[spot]==null or _enemies[spot].health <= 0:
			_enemies.erase(spot)
