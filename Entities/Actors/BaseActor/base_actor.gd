class_name BaseActor
extends CharacterBody2D

func set_texture_name(texture_name: String) -> void:
	$Sprite2D.texture = load(texture_name)

func _ready() -> void:
	pass
