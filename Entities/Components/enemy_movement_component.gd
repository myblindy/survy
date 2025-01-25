extends Node

@export var base_movement_multiplier := 600.0

@onready var _player: Player = get_tree().get_nodes_in_group("player").front()
@onready var _enemy: CharacterBody2D = get_parent()
@onready var _enemy_sprite: SpriteComponent = _enemy.get_node("SpriteComponent")

func _physics_process(delta: float) -> void:
	if _player != null:
		var velocity = _player.position - _enemy.position
		_enemy.velocity = velocity.normalized() * base_movement_multiplier * delta * 60.0
		_enemy_sprite.flip_h = velocity.x > 0
		_enemy.move_and_slide()
