class_name ProjectileContainer extends Node2D

var _projectiles: Array[Projectile]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProjectileStorage.set_container(self)
	ProjectileStorage.spawned.connect(_on_projectile_spawned)
	ProjectileStorage.despawned.connect(_on_projectile_despawned)

func _exit_tree() -> void:
	ProjectileStorage.reset_container()
	ProjectileStorage.spawned.disconnect(_on_projectile_spawned)
	ProjectileStorage.despawned.disconnect(_on_projectile_despawned)


func _on_projectile_spawned(projectile: Projectile):
	#print_debug("Adding to container " + str(projectile))
	#call_deferred("add_child", projectile)
	_projectiles.append(projectile)

func _on_projectile_despawned(projectile: Projectile):
	#print_debug("Adding to container " + str(projectile))
	#call_deferred("add_child", projectile)
	_projectiles.erase(projectile)
