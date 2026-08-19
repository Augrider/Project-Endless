class_name Launcher_Melee extends WeaponLauncher

#plays blade animation and checks for clashes. If clashing - call event
signal clash_occured(object)

#Spawn projectile, but tie it to yourself
@export var projectile_melee:PackedScene


func perform(attack_duration:float)->void:
	#var speed=clamp(animation.length/attack_duration, 1, 999999999)
#	animator.play(animation)
	spawn(projectile_melee)


func spawn(projectile_prefab:PackedScene, amount:int=1)->Array[Projectile]:
	var result:Array[Projectile]
	
	for i in amount:
		var projectile:Projectile = projectile_prefab.instantiate()
		
		add_child(projectile)
		projectile.global_position = global_position
		projectile.rotation = 0
		
		result.append(projectile)
	
	return result
