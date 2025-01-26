extends Node2D

@onready var _time_label := $CanvasLayer/TimeLabel
@onready var _game_entities := $GameEntities

@onready var _player_health_bar_progress_bar := $CanvasLayer/VBoxContainer/MarginContainer/PlayerHealthBarProgressBar
@onready var _player_health_bar_label := $CanvasLayer/VBoxContainer/MarginContainer/PlayerHealthBarLabel
@onready var _player_experience_bar_progress_bar := $CanvasLayer/VBoxContainer/MarginContainer2/PlayerExperienceBarProgressBar
@onready var _player_experience_bar_label := $CanvasLayer/VBoxContainer/MarginContainer2/PlayerExperienceBarLabel

var _time_sec := 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	GameState.signals.game_over.connect(func():
		get_tree().paused = true
		%GameOver.visible = true
	)

	GameState.signals.player_health_changed.connect(func(health: float, max_health: float):
		_player_health_bar_progress_bar.value = health
		_player_health_bar_progress_bar.max_value = max_health
		_player_health_bar_label.text = "Health: %d/%d" % [int(health), int(max_health)]
	)

	GameState.signals.player_experience_changed.connect(func(experience: float, max_level_experience: float):
		_player_experience_bar_progress_bar.value = experience
		_player_experience_bar_progress_bar.max_value = max_level_experience
		_player_experience_bar_label.text = "EXP: %d/%d" % [int(experience), int(max_level_experience)]
	)

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
			if _time_sec >= spawn_data.wave_time_sec:

				for i in range(spawn_data.actor_count):
					var spawner: ActorSpawner = GameState.actor_spawner_scene.instantiate()
					spawner.actor_scene_to_spawn = spawn_data.actor_scene
					spawner.position = Vector2(randf_range(-GameState.width / 2.0, GameState.width / 2.0), 
						randf_range(-GameState.height / 2.0, GameState.height / 2.0))
					_game_entities.add_child(spawner)

				_current_spawn_idx += 1

func _on_player_child_exiting_tree(_node: Node) -> void:
	GameState.signals.game_over.emit()
