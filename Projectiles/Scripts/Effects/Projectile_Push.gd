extends Node

#Push should be dependant on size of enemy. 
#Small and medium enemies are turned into projectile
#Bigger enemies push you instead
@export var owner_projectile:Projectile


#TODO: on any other object type hit - push owner away

func _on_unit_hit(unit:Unit):
	print_debug('Trying push with '+str(owner_projectile.power))
	if unit is Player:
	# Player push is not dependant on class, only power
		_push(unit, owner_projectile.global_position, owner_projectile.power)
	else:
		var player = Players.get_player()
		var enemy: Enemy = unit
		# Enemy push is based on size
		# If enemy is not bigger than big, then push enemy
		if enemy.size_class <= Enemy.SizeClass.BIG:
			_push(enemy, player.global_position, owner_projectile.power/enemy.size_class)
		# If enemy is bigger than small, then push player
		#if enemy.size_class > Enemy.SizeClass.SMALL:
			#_push(player, enemy.global_position, owner_projectile.power*enemy.size_class/2)



func _push(unit:Unit, origin: Vector2, power: float):
	var impulse = power * (unit.global_position - origin).normalized()
	print_debug("Impulse calculated "+str(impulse))
	unit.set_pushed(impulse)
