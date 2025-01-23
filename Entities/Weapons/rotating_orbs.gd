extends Node2D

@export var radius := 140.0
@export var orb_count := 3
@export var orb_speed := 2.0
@export var orb_scale := 1.0

var _orbs: Array[Node2D]
var _orb_scale := -1.0
var _radius := -1.0 
var _time_sec := 0.0

func _process(delta: float) -> void:
	if _orbs == null or _orbs.size() != orb_count or _orb_scale != orb_scale or _radius != radius:
		_orb_scale = orb_scale
		_radius = radius
		_orbs = []
		for i in range(orb_count):
			var orb := GameState.rotating_orb_scene.instantiate()
			orb.scale = Vector2(orb_scale, orb_scale)
			add_child(orb)
			_orbs.append(orb)

	_time_sec += delta
	for i in range(orb_count):
		_orbs[i].position = Vector2(cos(_time_sec * orb_speed + i * TAU / orb_count) * _radius, sin(_time_sec * orb_speed + i * TAU / orb_count) * _radius)
