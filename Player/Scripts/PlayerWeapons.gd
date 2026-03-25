class_name PlayerWeapons extends Node2D

@export var statsPath:NodePath
@onready var stats:PlayerStats=get_node(statsPath)

@export var weapon1DataRes:Resource
@onready var weapon1Data:WeaponData=weapon1DataRes

#Pivots
@export var weapon1PivotPath:NodePath
@onready var weapon1Pivot:Node2D=get_node(weapon1PivotPath)

@export var weapon2PivotPath:NodePath
@onready var weapon2Pivot:Node2D=get_node(weapon2PivotPath)

#Control shooting weapons, parry
var weapon1:Weapon
var weapon2:Weapon


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon1=weapon1Data.weaponPrefab.instantiate()
	weapon1.init(0)
	weapon1Pivot.add_child(weapon1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.get_action_strength("weapon_1"):
		press_trigger(weapon1)
	else:
		release_trigger(weapon1)

#TODO: load weapons from file and save them
func add_weapon(data:WeaponData)->void:
	pass


func press_trigger(weapon:Weapon)->void:
	weapon.press_trigger(get_parent(), stats.get_actual_weapon_stats(0, weapon1Data))

func release_trigger(weapon:Weapon)->void:
	weapon.release_trigger()
