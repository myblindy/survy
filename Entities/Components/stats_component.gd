extends Node
class_name StatsComponent

@onready var _actor := get_parent()

var damage_taken_multipliers := {
	GameState.DamageType.PHYSICAL: 1.0,
	GameState.DamageType.ARCANE: 1.0,
}

var damage_done_multipliers := {
	GameState.DamageType.PHYSICAL: 1.0,
	GameState.DamageType.ARCANE: 1.0,
}

var _experience := 0.0
var experience: float:
	set(new_experience):
		_experience = new_experience
		if _actor is Player:
			GameState.signals.player_experience_changed.emit(experience, 20)
	get:
		return _experience
		
@export var experience_base_drop := 0.0

@export_category("Damage Taken Multipliers")
@export var physical_damage_taken_multiplier := 1.0:
	set(new_value):
		damage_taken_multipliers[GameState.DamageType.PHYSICAL] = new_value
	get():
		return damage_taken_multipliers[GameState.DamageType.PHYSICAL]

@export var arcane_damage_taken_multiplier := 1.0:
	set(new_value):
		damage_taken_multipliers[GameState.DamageType.ARCANE] = new_value
	get():
		return damage_taken_multipliers[GameState.DamageType.ARCANE]

@export_category("Damage Done Multipliers")
@export var physical_damage_done_multiplier := 1.0:
	set(new_value):
		damage_done_multipliers[GameState.DamageType.PHYSICAL] = new_value
	get():
		return damage_done_multipliers[GameState.DamageType.PHYSICAL]

@export var arcane_damage_done_multiplier := 1.0:
	set(new_value):
		damage_done_multipliers[GameState.DamageType.ARCANE] = new_value
	get():
		return damage_done_multipliers[GameState.DamageType.ARCANE]
