extends WeaponLauncher

#@export var spreadMultiplier=1

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


func spawn(projectile_prefab:PackedScene, amount:int=1)->Array[Projectile]:
	var result:Array[Projectile]
	
	for i in amount:
		var projectile:Projectile = projectile_prefab.instantiate()
		
		get_tree().root.add_child(projectile)

		projectile.global_position = global_position
		projectile.rotate(global_rotation)
		
		result.append(projectile)
	
	return result
