extends WeaponLauncher

@export var spreadMultiplier=1

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


func spawn(projectilePrefab:PackedScene, spreadMax:float, amount:int=1)->Array:
	var result:Array
	spreadMax *= spreadMultiplier
	
	for i in amount:
		var spread=randf_range(-spreadMax, spreadMax)
		var projectile:Projectile = projectilePrefab.instantiate()
		
		get_tree().root.add_child(projectile)

		projectile.global_position=global_position+spread*global_transform.y
		projectile.rotate(global_rotation)
		
		result.append(projectile)
	
	return result
