extends Node2D
class_name ExperienceFood

static var materials := [
	preload("res://Entities/ExperienceFood/material_0000.png"),
	preload("res://Entities/ExperienceFood/material_0001.png"),
	preload("res://Entities/ExperienceFood/material_0002.png"),
	preload("res://Entities/ExperienceFood/material_0003.png"),
	preload("res://Entities/ExperienceFood/material_0004.png"),
	preload("res://Entities/ExperienceFood/material_0005.png"),
	preload("res://Entities/ExperienceFood/material_0006.png"),
	preload("res://Entities/ExperienceFood/material_0007.png"),
	preload("res://Entities/ExperienceFood/material_0008.png"),
	preload("res://Entities/ExperienceFood/material_0009.png"),
	preload("res://Entities/ExperienceFood/material_0010.png"),	
]

const MOVEMENT_SPEED_SEC := 1200.0

var experience_value := 1.0

enum State {
	STATE_MOVING_TO_INITIAL_POSITION,
	STATE_ACTIVE,
	STATE_WAITING,
	STATE_BEGIN_EATING,
	STATE_EATEN
}
var _state := State.STATE_MOVING_TO_INITIAL_POSITION
var target_position: Vector2
@onready var _player: Player = get_parent().find_child("Player") as Player

func _ready() -> void:
	$Sprite2D.texture = materials.pick_random()

var _time := 0.0
func _process(delta: float) -> void:
	_time += delta
	
	match _state:
		State.STATE_MOVING_TO_INITIAL_POSITION:
			var direction := target_position - position
			if direction.length() < 8.0 or _time >= 1:
				_state = State.STATE_ACTIVE
				position = target_position
			else:
				position += direction.normalized() * MOVEMENT_SPEED_SEC * delta
		State.STATE_ACTIVE:
			$Area2D.monitoring = true
			$Area2D.monitorable = true
			_state = State.STATE_WAITING
		State.STATE_BEGIN_EATING:
			$Area2D.monitoring = false
			$Area2D.monitorable = false
			_state = State.STATE_EATEN
		State.STATE_EATEN:
			var direction := _player.position - position
			if direction.length() < 20.0:
				(_player.find_child("StatsComponent") as StatsComponent).experience += experience_value
				queue_free()
			else:
				position += direction.normalized() * MOVEMENT_SPEED_SEC * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if _state == State.STATE_WAITING and area is HurtBoxComponent and area.get_parent() is Player:
		_state = State.STATE_BEGIN_EATING
