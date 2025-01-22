extends Node

@export var base_movement_multiplier := 800.0

@onready var _player: Player = get_parent()
@export var _sprite_component: SpriteComponent

func _physics_process(delta: float) -> void:
	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * base_movement_multiplier * delta
	_player.move_and_collide(velocity)
	
	if abs(velocity.x) > 0.01:
		_sprite_component.flip_h = velocity.x > 0
