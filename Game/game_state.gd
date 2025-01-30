class_name GameState
extends Object

#projectiles
static var rotating_orb_scene := preload("res://Entities/Projectiles/rotating_orb.tscn")
static var lightning_bolt_projectile := preload("res://Entities/Projectiles/lighting_bolt_projectile.tscn")

#weapons
static var rotating_orbs_scene := preload("res://Entities/Weapons/rotating_orbs.tscn")
static var chain_lightning_scene := preload("res://Entities/Weapons/chain_lightning.tscn")

#actors
static var player_scene := load("res://Entities/Actors/Player/player.tscn")
static var actor_spawner_scene := load("res://Entities/ActorSpawner/actor_spawner.tscn")
static var shitty_dude_scene := load("res://Entities/Actors/ShittyDude/shitty_dude.tscn")

#misc
static var sprite_melter_scene := preload("res://Entities/SpriteMelter/sprite_melter.tscn")
static var experience_food_scene := preload("res://Entities/ExperienceFood/experience_food.tscn")

enum DamageType {
	PHYSICAL,
	ARCANE,
}

class Damage:
	var amount: float
	var type: DamageType

	func _init(_amount: float = 1.0, _type: DamageType = DamageType.PHYSICAL) -> void:
		amount = _amount
		type = _type

class WaveData:
	var wave_length_sec: float
	var spawns: Array[WaveSpawnData]

	func _init(_wave_length_sec: float, _spawns: Array[WaveSpawnData]) -> void:
		wave_length_sec = _wave_length_sec
		spawns = _spawns

class WaveSpawnData:
	var wave_time_sec: float
	var actor_count: int
	var actor_scene: PackedScene

	func _init(_wave_time_sec: float, _actor_count: int, _actor_scene: PackedScene) -> void:
		wave_time_sec = _wave_time_sec
		actor_count = _actor_count
		actor_scene = _actor_scene

static var waves: Array[WaveData] = [
	WaveData.new(20.0, [
		WaveSpawnData.new(0, 3, shitty_dude_scene),
		WaveSpawnData.new(5, 4, shitty_dude_scene),
		WaveSpawnData.new(10, 6, shitty_dude_scene),
	]),
]

static var width := 2500
static var height := 2500

class Signals:
	signal player_health_changed(health: float, max_health: float)
	signal player_experience_changed(experience: float, max_level_experience: float)

	signal game_over
	signal wave_won
	signal game_won

static var signals := Signals.new()
