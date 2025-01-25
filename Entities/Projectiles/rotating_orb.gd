extends Node2D

@onready var _hit_box_component := $HitBoxComponent

func set_damage(damage: GameState.Damage) -> void:
	_hit_box_component.damage = damage
