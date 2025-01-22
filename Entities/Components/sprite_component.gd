extends Node2D
class_name SpriteComponent

@export var _sprite: Sprite2D

@export var flip_h: bool: 
	set(value):
		_sprite.flip_h = value
		_sprite.offset.x = abs(_sprite.offset.x) if value else -abs(_sprite.offset.x)
	get():
		return _sprite.flip_h

func _ready() -> void:
	_sprite.offset.x = -13
