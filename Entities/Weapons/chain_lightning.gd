extends Node2D

var _node_timer := NodeTimer.new()
@onready var _delta_position := (get_parent() as Node2D).position
@onready var _game_entities := get_tree().root.get_node("World").get_node("GameEntities")
@onready var _game_entities_overlay := get_tree().root.get_node("World").get_node("GameEntitiesOverlay")

const BASE_RANGE := 400.0
const BOUNCES := 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_node_timer.interval_sec = 1.0
	_node_timer.timeout.connect(func():
		var source := get_parent().get_parent() as Node2D
		var last_node := source
		var last_global_position := last_node.global_position
		var current_global_position := source.global_position
		var hit_targets: Array[Node2D] = []
		
		for _bounce in range(BOUNCES):
			# find the next bounce target
			var enemies_in_range := _game_entities.get_children().filter(func(child: Node) -> bool:
				return not hit_targets.has(child) and child.has_node("EnemyMovementComponent") and \
					child.global_position.distance_squared_to(current_global_position) < BASE_RANGE * BASE_RANGE
			)
			if enemies_in_range.is_empty():
				break

			var next_enemy: Node2D = enemies_in_range.pick_random()
			hit_targets.append(next_enemy)
			current_global_position = next_enemy.global_position

			# spawn the bolt
			var bolt: LightningBoltProjectile = GameState.lightning_bolt_projectile.instantiate()
			bolt.start_global_position = last_global_position
			if last_node != null:
				bolt.start_node = last_node 
			bolt.end_node = next_enemy
			bolt.source = source
			bolt.translate(_delta_position)
			_game_entities_overlay.add_child(bolt)

			last_node = next_enemy
			last_global_position = current_global_position

			await get_tree().create_timer(0.1, false).timeout
	)

func _process(delta: float) -> void:
	_node_timer.process(delta)
