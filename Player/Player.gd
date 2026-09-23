class_name Player extends Unit

const ALLEGIANCE: int = 0
# Handles input from top, health, weapons, movement...
# Does Godot allow good separation?

#export(NodePath) var inputPath
#var input:PlayerInput

#export(NodePath) var movementPath
#var movement:PlayerMovement


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Players.add_player(self)
	set_allegiance(ALLEGIANCE)

func _exit_tree() -> void:
	Players.remove_player(self)


func deal_damage(value:float):
	pass

func set_pushed(impulse:Vector2):
	pass


func get_held_weapons() -> Array[Weapon]:
	return [%Weapons.weapon1, %Weapons.weapon2]
