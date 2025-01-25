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

var _flash_reset_timer: SceneTreeTimer
func flash() -> void:
	if _flash_reset_timer:
		_flash_reset_timer.timeout.disconnect(_flash_reset)

	_sprite.modulate = Color(1, 0, 0)

	_flash_reset_timer = get_tree().create_timer(0.1, false)
	_flash_reset_timer.timeout.connect(_flash_reset)

func _flash_reset() -> void:
	_sprite.modulate = Color(1, 1, 1)
