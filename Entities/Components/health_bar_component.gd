extends Node2D

@onready var _progress_bar := $ProgressBar
@export var _health_component: HealthComponent

func _process(delta: float) -> void:
	if _health_component != null:
		_progress_bar.max_value = _health_component.max_health
		_progress_bar.value = _health_component.health
