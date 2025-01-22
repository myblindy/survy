extends Node

@export var max_health := 10.0

var health := 10.0

func _ready() -> void:
	health = max_health
