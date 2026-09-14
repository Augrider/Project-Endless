extends Node

signal spawned(projectile:Projectile)
signal despawned(projectile:Projectile)

signal spawn_requested(projectile:Projectile)
signal collision_requested(starter: Projectile, hit: Projectile)

var container:ProjectileContainer
var container_set:bool = false


func set_container(container:ProjectileContainer):
	self.container = container
	container_set = self.container != null

func reset_container():
	self.container = null
	container_set = false


func request_spawn(projectile_prefab:PackedScene) -> Projectile:
	var projectile:Projectile = projectile_prefab.instantiate()
	projectile.global_position = Vector2.ONE*10000
	
	if(container_set):
		container.add_child(projectile)
	
	spawn_requested.emit(projectile)
	return projectile

func request_collision(starter: Projectile, hit: Projectile):
	collision_requested.emit(starter, hit)
#TODO: Projectile Collisions should be better handled
#If one projectile hit another - both should perform calculations at the same time
#Otherwise, second projectile is already weakened before applying effects
#Where to store collisions, when to perform them?
#
