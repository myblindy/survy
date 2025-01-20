class_name Player
extends BaseActor

func is_enemy() -> bool:
	return false
	
func _ready() -> void:
	set_texture_name("res://Entities/Actors/Player/player.png")

func _physics_process(delta: float) -> void:
	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * 1000.0 * delta
	move_and_collide(velocity)
