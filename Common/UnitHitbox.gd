@abstract
class_name UnitHitbox extends Area2D

@export var owner_unit: Unit


func is_allied_with(allied_node:AlliedNode2D)->bool:
	return owner_unit.allegiance == allied_node.allegiance


@abstract func apply_damage(value: float)
