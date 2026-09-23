class_name ReactionArea2D extends Area2D

signal friendly_unit_enter(hit: UnitHitbox)
signal opponent_unit_enter(hit: UnitHitbox)

signal friendly_projectile_enter(projectile: Projectile)
signal opponent_projectile_enter(projectile: Projectile)

signal node_exited(node: Node2D)

@export var owner_node: AlliedNode2D
#var _collided_objects: Array[Node2D]


func start():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	
	body_exited.connect(_on_body_exited)
	area_exited.connect(_on_area_exited)

#func add_to_collided(node2D: Node2D):
	#_collided_objects.append(node2D)
#
#func remove_from_collided(node2D: Node2D):
	#_collided_objects.erase(node2D)
#
#func collided_with(node2D: Node2D) -> bool:
	#return _collided_objects.has(node2D)


func _on_body_entered(body: Node2D):
	#if collided_with(body):
		#return
	if body is Projectile:
		_call_projectile_enter(body)
		#add_to_collided(body)
	#elif body is MapObject:
		#object_hit.emit(body)

func _on_area_entered(area: Area2D):
	#if collided_with(area):
		#return
	
	if area is UnitHitbox:
		_call_unit_hitbox_enter(area)
		#add_to_collided(area)

func _on_body_exited(body: Node2D):
	node_exited.emit(body)

func _on_area_exited(area: Area2D):
	node_exited.emit(area)


func _call_unit_hitbox_enter(hitbox: UnitHitbox):
	if hitbox.is_allied_with(owner_node):
		friendly_unit_enter.emit(hitbox)
	else:
		opponent_unit_enter.emit(hitbox)


func _call_projectile_enter(projectile: Projectile):
	if projectile.is_allied_with(owner_node):
		friendly_projectile_enter.emit(projectile)
	else:
		opponent_projectile_enter.emit(projectile)
