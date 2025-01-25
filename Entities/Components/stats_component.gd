extends Node
class_name StatsComponent

var damage_taken_multipliers := {
	GameState.DamageType.PHYSICAL: 1.0,
	GameState.DamageType.ARCANE: 1.0,
}

var damage_done_multipliers := {
	GameState.DamageType.PHYSICAL: 1.0,
	GameState.DamageType.ARCANE: 1.0,
}

@export_group("Damage Taken Multipliers")
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

@export_group("Damage Done Multipliers")
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
