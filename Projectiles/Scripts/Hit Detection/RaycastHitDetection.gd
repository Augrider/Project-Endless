extends RayCast2D
signal player_hit(player: Player)
signal enemy_hit(enemy: Enemy)

#TODO: Wall, ground if needed

signal any_hit(object: Node2D)

const MAX_LENGTH := 100

#Hits are invoked once per tick timer
@export var _tick_timer: Timer

#TODO: Add logic
