extends Node

#Damage should be dependant on power
#TODO: Add centralized collisions resolve if nessesary
@export var owner_projectile:Projectile


func _on_projectile_hit(projectile: Projectile) -> void:
	print_debug("Projectile collided with projectile")
	projectile.reduce_power(owner_projectile.power)
	#owner_projectile.reduce_power(projectile.power)

func _on_player_hit(player:Player):
	player.deal_damage()
	owner_projectile.destroy()

func _on_enemy_hit(enemy:Enemy):
	enemy.queue_free()
	owner_projectile.destroy()
