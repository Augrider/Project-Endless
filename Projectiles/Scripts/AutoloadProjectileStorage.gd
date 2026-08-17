extends Node

signal spawned(projectile:Projectile)
signal despawned(projectile:Projectile)

var container:ProjectileContainer
var container_set:bool = false


func set_container(container:ProjectileContainer):
	self.container = container
	container_set = self.container != null

func reset_container():
	self.container = null
	container_set = false
