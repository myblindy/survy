extends Node
class_name HealthComponent

@onready var _actor := get_parent()

@export var _sprite_component: SpriteComponent
@export var _stats_component: StatsComponent

const DAMAGE_PROTECTION_SEC := 0.2
var _damage_protection_data := {}

var _max_health := 10.0

@export var max_health: float:
	set(new_max_health):
		_max_health = new_max_health
		if _actor is Player:
			GameState.signals.player_health_changed.emit(health, max_health)
	get:
		return _max_health

@export var auto_destroy_on_death := true

var _health: float
var health: float:
	set(new_health):
		_health = clamp(new_health, 0, max_health)
		if _actor is Player:
			GameState.signals.player_health_changed.emit(health, max_health)
	get:
		return _health

func _ready() -> void:
	health = max_health

func take_damage(damage: GameState.Damage, source: Node2D) -> void:
	var now_sec := Time.get_ticks_usec() / 1e6
	var source_expiry_sec: float = _damage_protection_data.get_or_add(source, 0)
	
	if source_expiry_sec <= now_sec:
		health -= damage.amount * _stats_component.damage_taken_multipliers[damage.type] as float * \
			(source.find_child("StatsComponent") as StatsComponent).damage_done_multipliers[damage.type] as float
		
		if health <= 0 and auto_destroy_on_death:
			get_parent().queue_free()
		else:
			_damage_protection_data[source] = now_sec + DAMAGE_PROTECTION_SEC
			_sprite_component.flash()

static var _fractional_experience_drop := 0.0
const EXPERIENCE_DROP_GROUND_RADIUS := 80.0
func _on_tree_exiting() -> void:
	#spawn food when enemies die
	var enemy := get_parent()
	if enemy is Player:
		return
	
	_fractional_experience_drop += _stats_component.experience_base_drop
	for i in range(int(_fractional_experience_drop)):
		var food: ExperienceFood = GameState.experience_food_scene.instantiate()
		food.target_position = enemy.position + Vector2(
			randf_range(-EXPERIENCE_DROP_GROUND_RADIUS, EXPERIENCE_DROP_GROUND_RADIUS), 
			randf_range(-EXPERIENCE_DROP_GROUND_RADIUS, EXPERIENCE_DROP_GROUND_RADIUS))
		food.position = enemy.position
		get_parent().get_parent().add_child.call_deferred(food)
	_fractional_experience_drop -= int(_fractional_experience_drop)
