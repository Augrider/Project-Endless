class_name PursuitAttackStrategy extends EnemyAttackStrategy

@export var chasers_count: int = 1
@export var cooldown: float


func perform(formation: CircleFormation2D, timers: TimerProvider):
	active = true
	
	print_debug("Started pursuit")
	var chasers: EnemyGroup = _pick_enemies(EnemyGroup.new(), formation)
	_send_chasers(chasers, formation)
	
	await  timers.get_oneshot(cooldown).timeout
	active = false

func stop():
	active = false
#Get timer for repeating actions


func _pick_enemies(group: EnemyGroup, formation: CircleFormation2D) -> EnemyGroup:
	group.clear()
	
	var enemies = formation.get_inner_enemies()
	if enemies.size() <= 0:
		return group
	
	for i in range(chasers_count):
		group.append(enemies.pick_random())
	
	return group

func _send_chasers(group: EnemyGroup, formation: CircleFormation2D):
	for enemy in group.get_enemies():
		formation.remove(enemy)
		enemy.perform_ability_chase()
