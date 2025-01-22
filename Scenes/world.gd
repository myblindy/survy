extends Node2D

@onready var _time_label: Label = $CanvasLayer/TimeLabel
var _time_sec := 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	# spawn the player
	var player: Player = GameState.player_scene.instantiate()
	player.position = Vector2(GameState.width / 2.0, GameState.height / 2.0)
	add_child(player)
	player.add_to_group("player")

var _current_wave_idx := 0
var _current_spawn_idx := 0
func _process(delta: float) -> void:
	_time_sec += delta

	# time label
	var time_min := int(_time_sec / 60)
	var time_sec := fmod(_time_sec, 60)
	_time_label.text = "Wave %d\n%02d:%02d" % [_current_wave_idx + 1, time_min, time_sec]

	# spawn actors
	if _current_wave_idx < len(GameState.waves):
		var wave := GameState.waves[_current_wave_idx]

		if _current_spawn_idx < len(wave.spawns):
			var spawn_data := wave.spawns[_current_spawn_idx]
			if _time_sec >= spawn_data[0]:

				for i in range(spawn_data[1]):
					var spawner: ActorSpawner = GameState.actor_spawner_scene.instantiate()
					spawner.actor_scene_to_spawn = spawn_data[2]
					spawner.position = Vector2(randf_range(30, GameState.width - 60), randf_range(30, GameState.height - 60))
					add_child(spawner)

				_current_spawn_idx += 1
