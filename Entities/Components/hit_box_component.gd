@tool

extends Area2D
class_name HitBoxComponent

@export var parent_is_enemy: bool:
	set(new_parent_is_enemy):
		collision_mask = 2 if new_parent_is_enemy else 4
		collision_layer = collision_mask
	get():
		return collision_mask == 2

func get_damage(target: Node2D) -> float:
	return 1
