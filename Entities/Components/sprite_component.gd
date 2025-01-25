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

	_flash_reset_timer = get_tree().create_timer(0.2, false)
	_flash_reset_timer.timeout.connect(_flash_reset)

func _flash_reset() -> void:
	_sprite.modulate = Color(1, 1, 1)

func get_texture() -> Texture2D:
	return _sprite.texture

func get_texture_region_rect() -> Rect2:
	return _sprite.region_rect

func _on_tree_exiting() -> void:
	#sprite is dying, spawn the melter
	var melter: SpriteMelter = GameState.sprite_melter_scene.instantiate()
	melter.initialize_from_sprite_component(self)
	melter.global_position = global_position + _sprite.offset
	get_parent().get_parent().add_child.call_deferred(melter)
