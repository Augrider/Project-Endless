class_name Enemy extends CharacterBody2D

enum SizeClass { SMALL=1, MEDIUM=2, BIG=3, LARGE=4 }

@export var ability_targeted:EnemyAbility
@export var ability_spread:EnemyAbility
@export var ability_arena:EnemyAbility
@export var ability_chase:EnemyAbility

@export var size_class: SizeClass


func _ready() -> void:
	EnemyStorage.spawned.emit(self)

func _exit_tree() -> void:
	EnemyStorage.despawned.emit(self)


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

func perform_ability_targeted(duration:float, intensity:=1.0):
	await ability_targeted.perform(self, duration, intensity)

func perform_ability_spray(duration:float, intensity:=1.0):
	await ability_spread.perform(self, duration, intensity)

func perform_ability_arena(duration:float, intensity:=1.0):
	await ability_arena.perform(self, duration, intensity)

func perform_ability_chase(duration:float, intensity:=1.0):
	await ability_chase.perform(self, duration, intensity)
