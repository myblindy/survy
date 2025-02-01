extends Node2D
class_name DamageNumber

func set_damage(damage: GameState.Damage, source: Node2D):
	$Label.text = str(roundi(damage.amount))

var _time_sec := 0.0
func _process(delta: float) -> void:
	translate(Vector2(randf_range(-0.5, 0.5), randf_range(-1.0, 0.0)) * 500.0 * delta)

	_time_sec += delta
	if _time_sec >= 1.0:
		queue_free()
