class_name PursuitAttackStrategy extends EnemyAttackStrategy

@export var chasers_count: int = 1
@export var cooldown: float


func perform(arena: Arena):
	active = true
	
	var formation = arena.formation
	
	print_debug("Started pursuit")
	var chasers: EnemyGroup = _pick_enemies(EnemyGroup.new(), formation, arena)
	_send_chasers(chasers, formation, arena)
	
	await Timers.get_oneshot(cooldown).timeout
	active = false

func stop():
	active = false


func _pick_enemies(group: EnemyGroup, formation: CircleFormation2D, arena: Arena) -> EnemyGroup:
	group.clear()
	
	var enemies = formation.get_inner_enemies()
	if enemies.size() <= 0:
		return group
	
	var new_count = chasers_count - arena.chasers.size()
	
	if new_count <= 0:
		return group
	
	for i in range(new_count):
		group.append(enemies.pick_random())
	
	return group

func _send_chasers(group: EnemyGroup, formation: CircleFormation2D, arena: Arena):
	for enemy in group.get_enemies():
		formation.remove(enemy)
		arena.chasers.append(enemy)
		
		enemy.stop_abilities()
		enemy.perform_ability_chase(arena)
