extends Node

#Damage should be dependant on power
#TODO: Add centralized collisions resolve if nessesary
@export var owner_projectile:Projectile


func _on_opponent_projectile_hit(projectile: Projectile) -> void:
	projectile.reduce_power(owner_projectile.power)
	#owner_projectile.reduce_power(projectile.power)

func _on_unit_hit(unit:Unit):
	unit.deal_damage(owner_projectile.power)
	owner_projectile.destroy()
