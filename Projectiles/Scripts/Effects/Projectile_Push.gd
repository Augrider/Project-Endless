extends Node

#Push should be dependant on size of enemy. 
#Small and medium enemies are turned into projectile
#Bigger enemies push you instead
@export var owner_projectile:Projectile


func _on_player_hit(player:Player):
	# Player push is not dependant on class, only power
	push(player, owner_projectile.global_position, owner_projectile.power)

func _on_enemy_hit(enemy:Enemy):
	var player = Players.get_player()
	# Enemy push is based on size
	# If enemy is not bigger than big, then push enemy
	if enemy.size_class <= Enemy.SizeClass.BIG:
		push(enemy, player.global_position, owner_projectile.power/enemy.size_class)
	# If enemy is bigger than small, then push player
	if enemy.size_class > Enemy.SizeClass.SMALL:
		push(player, enemy.global_position, owner_projectile.power*enemy.size_class/2)



func push(node:Node2D, origin: Vector2, power: float):
	pass
