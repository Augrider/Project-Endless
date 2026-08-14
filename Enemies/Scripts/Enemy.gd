class_name Enemy extends CharacterBody2D

@export var projectile_prefab: PackedScene


func _ready() -> void:
	pass

func _exit_tree() -> void:
	pass


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

func perform_ability(target:Node2D):
	%Launcher.look_at(target.global_position)
	
	var projectiles = %Launcher.spawn(projectile_prefab)
	
	for projectile:Projectile in projectiles:
		projectile.init()
