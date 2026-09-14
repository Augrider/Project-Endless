extends Node

class Collision:
	var starter: Projectile
	var hit: Projectile

var _collisions: Array[Collision]
var _pending: Array[Collision]


func _ready() -> void:
	ProjectileStorage.collision_requested.connect(_on_collision_requested)

func _process(delta: float) -> void:
	if _pending.size() >= 0:
		call_deferred("_resolve_collisions")

#TODO: If one of projectiles removed - erase every collision with it


func _on_collision_requested(starter: Projectile, hit: Projectile):
	var reverse := Collision.new()
	reverse.starter = hit
	reverse.hit = starter

	if _collisions.has(reverse):
		_collisions.erase(reverse)
		return
	
	var collision := Collision.new()
	collision.starter = starter
	collision.hit = hit
	
	_pending.append(collision)
	_collisions.append(collision)

func _resolve_collisions():
	for collision in _pending:
		pass
	
	_pending.clear()
