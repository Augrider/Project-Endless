class_name Enemy extends Unit

enum SizeClass { SMALL=1, MEDIUM=2, BIG=3, LARGE=4 }

@export var ability_targeted: EnemyAbility
@export var ability_spread: EnemyAbility
@export var ability_arena: EnemyAbility
@export var ability_chase: EnemyAbility

@export var size_class: SizeClass

@export var max_health: float = 10.0
var health: float

var intensity: float = 1.0

var current_ability: EnemyAbility


func _ready() -> void:
	health = max_health
	EnemyStorage.spawned.emit(self)

func _exit_tree() -> void:
	EnemyStorage.despawned.emit(self)


func deal_damage(value:float):
	health -= value
	if health < 0:
		queue_free()

func set_pushed(impulse:Vector2):
	#Set impulse to movement, it will handle movement
	#Movement will provide signals for push
	%Movement.set_impulse(impulse)


func follow_target(target:Node2D):
	%Movement.follow_target(target)

func go_to_target(position:Vector2):
	%Movement.go_to_target(position)

func stop_moving():
	%Movement.stop_moving()


func look_at_target(target:Node2D):
	%Visuals.look_at_target(target)

func look_at_position(position:Vector2):
	%Visuals.look_at_position(position)

func stop_looking():
	%Visuals.stop_looking()


#TODO: Some way to get a target. Give all valid targets as struct?

#Abilities for units:
#	Formation attack. Two modes: spray and targeted
#	Chase attack (change behavior and go to arena and actively engage player)
#	Arena attack (shoot in the middle of arena for a duration. May be useless)
#Other abilities are solely part of each enemy and activate by conditions
#Bosses can operate under chase attack, having entire AI with patterns hidden inside
#Add stop current ability

#TODO: Add stop current ability
#We want to continue to perform behavior until called to stop
#Either have ability on repeat or start after each perform cycle
#Second way is more controllable
func perform_ability_targeted() -> bool:
	if current_ability != null:
		return false
	
	_start_ability(ability_targeted)
	return true

func perform_ability_spray() -> bool:
	if current_ability != null:
		return false
	
	_start_ability(ability_spread)
	return true

func perform_ability_arena() -> bool:
	if current_ability != null:
		return false
	
	_start_ability(ability_arena)
	return true

func perform_ability_chase() -> bool:
	if current_ability != null:
		return false
	
	_start_ability(ability_chase)
	return true

func stop_abilities():
	if current_ability != null:
		current_ability.stop()
		current_ability = null # We can safely do that, abilities should stop at place


func _start_ability(ability: EnemyAbility):
	current_ability = ability
	
	await ability.perform(self)
	
	if current_ability == ability && !ability.active:
		current_ability = null
