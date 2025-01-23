class_name GameState
extends Object

#projectiles
static var rotating_orb_scene := preload("res://Entities/Projectiles/rotating_orb.tscn")

#weapons
static var rotating_orbs_scene := preload("res://Entities/Weapons/rotating_orbs.tscn")

#actors
static var player_scene := load("res://Entities/Actors/Player/player.tscn")
static var actor_spawner_scene := preload("res://Entities/ActorSpawner/actor_spawner.tscn")
static var shitty_dude_scene := preload("res://Entities/Actors/ShittyDude/shitty_dude.tscn")

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
