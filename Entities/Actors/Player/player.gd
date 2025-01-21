class_name Player
extends BaseActor

@onready var sprite := $Sprite2D

func is_enemy() -> bool:
	return false

func _physics_process(delta: float) -> void:
	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * 800.0 * delta
	move_and_collide(velocity)
	
	sprite.flip_h = velocity.x > 0
