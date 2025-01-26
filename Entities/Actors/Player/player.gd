class_name Player
extends CharacterBody2D

func _on_tree_entered() -> void:
	GameState.signals.player_health_changed.emit($HealthComponent.health, $HealthComponent.max_health)
	GameState.signals.player_experience_changed.emit($StatsComponent.experience, 20)
