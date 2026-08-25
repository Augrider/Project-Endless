extends Node2D

@export var player:Player

@export var enemy_prefab:PackedScene

@export var inner_circle: Formation2D
@export var outer_circle: Formation2D

var wave_ready:bool = false
var someone_died:bool = false


func _ready() -> void:
	EnemyStorage.despawned.connect(_on_enemy_despawned)
	Turns.new_turn_started.connect(spawn_wave)


func spawn_wave() -> void:
	for spot in outer_circle.get_spots_available():
		spawn_new(enemy_prefab, outer_circle, spot)
	
	for spot in inner_circle.get_spots_available():
		spawn_new(enemy_prefab, inner_circle, spot)
	
	wave_ready=true

func _process(delta:float) -> void:
	#Look at enemies at circles, do rearrangement
	
	if !wave_ready || !someone_died:
		return
	
	call_deferred("_move_everyone_to_front")


func _on_enemy_despawned(enemy:Enemy):
	inner_circle.remove(enemy)
	outer_circle.remove(enemy)
	
	someone_died = true


func _on_wave_attack_timer() -> void:
	#Need to get attacker from currently present enemies
	#Get enemy array before each attack
	#Alternatively, give tasks without wait, let enemies handle time themselves
	var enemy:Enemy
	
	for i in inner_circle.size:
		enemy = inner_circle.get_enemy(i)
		
		if enemy == null:
			continue
		
		enemy.perform_ability_targeted(1, 2)
		
		await get_tree().create_timer(0.3).timeout
	
	#Select random enemy
	var _active_enemies := inner_circle.get_enemies()
	_active_enemies.shuffle()
	enemy = _active_enemies[0]
	var spot_position := enemy.global_position
	
	if enemy == null:
		return
	
	enemy.follow_target(player)
	await get_tree().create_timer(2).timeout
	
	if enemy == null:
		return
	
	await enemy.perform_ability_chase(3, 5)
	await get_tree().create_timer(0.2).timeout
	
	if enemy == null:
		return
	
	enemy.go_to_target(spot_position)


func _move_everyone_to_front():
	while inner_circle.any_spot_available() && _move_to_front():
		pass
	
	#Spawn new enemies
	#for spot in outer_circle.get_spots_available():
		#spawn_new(enemy_prefab, outer_circle, spot)
	
	someone_died = false


func _get_closest(target:Vector2, candidates:Array[Enemy])->Enemy:
	#if candidates.size()<=0:
		#return null
	
	var dis = 99999999
	var closest: Enemy
	
	var temp_dis
	
	for n in candidates:
		temp_dis = target.distance_squared_to(n.position)
		if temp_dis < dis:
			dis = temp_dis
			closest = n
	
	return closest

func _move_to_front() -> bool:
	if outer_circle.count()<=0:
		return false
	
	var free_spot:int = inner_circle.get_spots_available()[0]
	var outer_enemies := outer_circle.get_enemies()
	var new_enemy := _get_closest(inner_circle.get_spot(free_spot), outer_enemies)
	
	if new_enemy == null:
		return false
	
	outer_circle.remove(new_enemy)
	var target = inner_circle.append_to_spot(new_enemy, free_spot)
	
	new_enemy.go_to_target(target)
	
	return true


func spawn_new(enemy_prefab:PackedScene, formation:Formation2D, spot:int):
		var enemy:Enemy = EnemyStorage.request_spawn(enemy_prefab)
		
		enemy.set_allegiance(1)
		enemy.global_position = formation.append_to_spot(enemy, spot)
		enemy.go_to_target(enemy.global_position)
		enemy.look_at_target(player)
