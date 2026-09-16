extends Area2D

signal friendly_hit(hit: UnitHitbox)
signal opponent_hit(hit: UnitHitbox)

signal friendly_projectile_hit(projectile: Projectile)
signal opponent_projectile_hit(projectile: Projectile)

#TODO: Wall, ground if needed

signal object_hit(object: MapObject)

@export var owner_projectile:Projectile

var _collided_objects: Array[Node2D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


func add_to_collided(node2D: Node2D):
	_collided_objects.append(node2D)

func remove_from_collided(node2D: Node2D):
	_collided_objects.erase(node2D)

func collided_with(node2D: Node2D) -> bool:
	return _collided_objects.has(node2D)


func _on_body_entered(body: Node2D):
	if collided_with(body):
		return
	
	if body is Projectile:
		add_to_collided(body)
		apply_effects_to_projectile(body)
	elif body is MapObject:
		object_hit.emit(body)

func _on_area_entered(area: Area2D):
	if collided_with(area):
		return

	if area is UnitHitbox:
		add_to_collided(area)
		apply_effects_to_unit_hitbox(area)


func apply_effects_to_unit_hitbox(hitbox: UnitHitbox):
	if hitbox.is_allied_with(owner_projectile):
		friendly_hit.emit(hitbox)
	else:
		opponent_hit.emit(hitbox)


func apply_effects_to_projectile(projectile: Projectile):
	if projectile.is_allied_with(owner_projectile):
		friendly_projectile_hit.emit(projectile)
	else:
		opponent_projectile_hit.emit(projectile)
	
	#Call collision on other projectile too
	projectile.call_collision_with(owner_projectile)
