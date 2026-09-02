class_name DebugAttackStrategy extends EnemyAttackStrategy

@export var chasers_count: int = 1
@export var spreaders_count: int = 1
@export var targeters_count: int = 1

var formation: CircleFormation2D
var intensity: float


func perform(formation: CircleFormation2D, timers: TimerProvider, intensity: float):
	self.formation = formation
	self.intensity = intensity
	
	var enemies = formation.get_inner_enemies()
	if enemies.size() <= 0:
		return
	
	var chasers: EnemyGroup = EnemyGroup.new()
	var shoot_timer := timers.get_timer()
	
	shoot_timer.timeout.connect(_on_repeat_attack)
	
	for i in range(chasers_count):
		chasers.append(enemies.pick_random())
	
	for enemy in chasers.get_enemies():
		formation.remove(enemy)
	
	shoot_timer.start(0.5)
	
	while chasers.size() > 0:
		for enemy in chasers.get_enemies():
			enemy.perform_ability_chase(10, intensity)
		
		await timers.get_oneshot(0.5).timeout
	
	shoot_timer.stop()

#Get timer for repeating actions

func _on_repeat_attack():
	var enemies = formation.get_inner_enemies()
	if enemies.size() <= 0:
		return
	
	var shooters: Array[Enemy]
	
	for i in range(spreaders_count):
		shooters.append(enemies.pick_random())
	
	for enemy in shooters:
		enemy.perform_ability_spray(0.5, intensity)
