extends Node2D

@export var health_component: HealthComponent
@onready var _game_entities_text_overlay: Node2D = get_tree().root.get_node("World").get_node("GameEntitiesTextOverlay")

func _ready() -> void:
	health_component.damage_taken.connect(func(damage: GameState.Damage, source: Node2D):
		var damage_taken_number: DamageNumber = GameState.damage_number_scene.instantiate()
		damage_taken_number.set_damage(damage, source)
		damage_taken_number.global_position = global_position
		_game_entities_text_overlay.add_child(damage_taken_number)
	)
