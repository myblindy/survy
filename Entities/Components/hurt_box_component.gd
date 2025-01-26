@tool

extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent
@onready var _actor: Node2D = get_parent()

var _intersections: Array[HitBoxComponent] = []

@export var parent_is_enemy: bool:
	set(new_parent_is_enemy):
		collision_mask = 4 if new_parent_is_enemy else 2
		collision_layer = collision_mask
	get():
		return collision_mask == 4

func _on_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		_intersections.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area is HitBoxComponent:
		_intersections.erase(area)
		
func _process(_delta: float) -> void:
	for intersection in _intersections:	
		health_component.take_damage(intersection.damage, _actor)
