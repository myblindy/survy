extends Node
class_name HealthComponent

@export var max_health := 10.0
@export var auto_destroy_on_death := true

var health := 10.0

func _ready() -> void:
	health = max_health

func take_damage(damage: float) -> void:
	health -= damage
	
	if health <= 0 and auto_destroy_on_death:
		queue_free()
