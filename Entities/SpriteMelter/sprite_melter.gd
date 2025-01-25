extends Node2D
class_name SpriteMelter

@onready var _polygon: Polygon2D = %Polygon2D

const _subdivision_count = 10
var _polygon_data: Array[Vector2] = []
var _polygon_y_melt_speed_per_sec: Array[float] = []
var _uv_data: Array[Vector2] = []
var _texture: Texture2D
var _region_rect: Rect2

const MELT_DURATION_SEC := 1.0
const WAIT_DURATION_SEC := 2.0

func initialize_from_sprite_component(sprite_component: SpriteComponent) -> void:
	var texture := sprite_component.get_texture()
	var region_rect := sprite_component.get_texture_region_rect()

	#top row
	for i in range(0, _subdivision_count + 1):
		_polygon_data.append(Vector2(i * region_rect.size.x / _subdivision_count - region_rect.size.x / 2.0, -region_rect.size.y / 2.0))
		var _i = i if not sprite_component.flip_h else _subdivision_count - i
		_uv_data.append(Vector2(_i * region_rect.size.x / _subdivision_count + region_rect.position.x, region_rect.position.y))
		
	#bottom row
	for i in range(_subdivision_count, -1, -1):
		_polygon_data.append(Vector2(i * region_rect.size.x / _subdivision_count - region_rect.size.x / 2.0, region_rect.size.y / 2.0))
		var _i = i if not sprite_component.flip_h else _subdivision_count - i
		_uv_data.append(Vector2(_i * region_rect.size.x / _subdivision_count + region_rect.position.x, region_rect.position.y + region_rect.size.y))

	#melt speeds
	var median_y_delta := region_rect.size.y / MELT_DURATION_SEC * 0.8
	for i in range(0, _subdivision_count + 1):
		_polygon_y_melt_speed_per_sec.append(median_y_delta * randf_range(1.0 / 20.0, 20.0))

	_texture = texture
	_region_rect = region_rect

func _ready() -> void:
	_polygon.texture = _texture
	_polygon.polygon = _polygon_data
	_polygon.uv = _uv_data

	#timer to keep track of states
	get_tree().create_timer(MELT_DURATION_SEC, false).timeout.connect(func():
		# state 2, wait
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
		get_tree().create_timer(WAIT_DURATION_SEC, false).timeout.connect(func():
			queue_free()
		)
	)

func _process(delta: float) -> void:
	for i in range(_polygon_data.size() / 2.0):
		_polygon_data[i].y = min(_polygon_data[i].y + _polygon_y_melt_speed_per_sec[i] * delta, _polygon_data[i + _subdivision_count + 1].y - 20.0)
	_polygon.polygon = _polygon_data
