class_name DebugAttackStrategy extends EnemyAttackStrategy

@export var chasers_count: int = 1
@export var spreaders_count: int = 1
@export var targeters_count: int = 1

func perform(formation: CircleFormation2D, intensity: float):
	var enemies = formation.get_inner_enemies()
	if enemies.size() <= 0:
		return
	
	var chasers: EnemyGroup = EnemyGroup.new()
	
	for i in range(chasers_count):
		chasers.append(enemies.pick_random())
	
	while chasers.size() > 0:
		for enemy in chasers.get_enemies():
			enemy.perform_ability_chase(10, intensity)
		
		await formation.get_tree().create_timer(0.5).timeout
		#count = _get_chaser_alive_count(chasers)
		print_debug(chasers.size())


#func _get_chaser_alive_count(chasers: Array[Enemy]) -> int:
	#if chasers.size() <= 0:
		#return false
	#
	#var count = 0
	#
	#for enemy in chasers:
		#if enemy == null or enemy.health <= 0:
			#pass
		#else:
			#count += 1
	#
	#return count
