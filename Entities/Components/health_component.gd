extends Node
class_name HealthComponent

const DAMAGE_PROTECTION_SEC := 0.2
var _damage_protection_data := {}

@export var max_health := 10.0
@export var auto_destroy_on_death := true

var health := 10.0

func _ready() -> void:
	health = max_health

func take_damage(damage: float, source: Node2D) -> void:
	var now_sec := Time.get_ticks_usec() / 1e6
	var source_expiry_sec: float = _damage_protection_data.get_or_add(source, 0)
	
	if source_expiry_sec <= now_sec:
		health -= damage
		
		if health <= 0 and auto_destroy_on_death:
			get_parent().queue_free()
		else:
			_damage_protection_data[source] = now_sec + DAMAGE_PROTECTION_SEC
