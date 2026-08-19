extends Area2D

signal friendly_hit(hit:Unit)
signal opponent_hit(hit:Unit)

signal friendly_projectile_hit(projectile: Projectile)
signal opponent_projectile_hit(projectile: Projectile)

#TODO: Wall, ground if needed

#signal object_hit(object: Node2D)


@export var owner_projectile:Projectile


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	var allied := false
	
	if body is AlliedNode2D:
		allied = body.is_allied_with(owner_projectile)
	
	if body is Unit:
		if allied:
			friendly_hit.emit(body)
		else:
			opponent_hit.emit(body)
		
	elif body is Projectile:
		if allied:
			friendly_projectile_hit.emit(body)
		else:
			opponent_projectile_hit.emit(body)
	
	#any_hit.emit(body)
