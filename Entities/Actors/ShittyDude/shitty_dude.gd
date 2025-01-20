class_name ShittyDude
extends BaseActor

func is_enemy() -> bool:
	return true

func _ready() -> void:
	set_texture_name("res://Entities/Actors/ShittyDude/shitty_dude.png")
