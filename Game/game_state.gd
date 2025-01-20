class_name GameState
extends Object

static var player_scene := preload("res://Entities/Actors/Player/player.tscn")
static var actor_spawner_scene := preload("res://Entities/ActorSpawner/actor_spawner.tscn")
static var shitty_dude_scene := preload("res://Entities/Actors/ShittyDude/shitty_dude.tscn")

static var spawns := [
	[0, 4, shitty_dude_scene],
	[5, 4, shitty_dude_scene],
	[15, 8, shitty_dude_scene],
	[25, 8, shitty_dude_scene],
]

static var width := 2500
static var height := 2500
