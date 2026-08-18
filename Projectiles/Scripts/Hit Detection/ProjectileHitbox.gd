extends Area2D

signal player_hit(player: Player)
signal enemy_hit(enemy: Enemy)

signal projectile_hit(projectile: Projectile)

#TODO: Wall, ground if needed

signal any_hit(object: Node2D)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	if body is Player:
		player_hit.emit(body)
	elif body is Enemy:
		enemy_hit.emit(body)
	elif body is Projectile:
		projectile_hit.emit(body)
	
	any_hit.emit(body)
