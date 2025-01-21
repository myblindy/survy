class_name ShittyDude
extends BaseEnemy

func _physics_process(delta: float) -> void:
	velocity = player.position - position
	velocity = velocity.normalized() * 700.0
	move_and_slide()
