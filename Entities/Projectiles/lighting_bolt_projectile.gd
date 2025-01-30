extends Line2D
class_name LightningBoltProjectile

var source: Node2D
var start_global_position: Vector2
var start_node: Node2D
var end_node: Node2D

func _ready() -> void:
	var _end_node_health_component: HealthComponent = end_node.get_node("HealthComponent")
	_end_node_health_component.take_damage(GameState.Damage.new(3.0, GameState.DamageType.ARCANE), source)
	points = [start_global_position, end_node.global_position]

	await get_tree().create_timer(0.3).timeout
	queue_free()

func _process(_delta: float) -> void:
	if start_node != null and end_node != null:
		points = [start_node.global_position, end_node.global_position]
