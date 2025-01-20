class_name ActorSpawner
extends Node2D

@onready var _sprite := $ActorSpawnerSprite
var _sprite_shader_material: ShaderMaterial

@export var duration_sec := 3.0
var actor_scene_to_spawn: PackedScene

var _lifetime_duration_sec: float
func _ready() -> void:
	_sprite_shader_material = _sprite.material

func _process(delta: float) -> void:
	_lifetime_duration_sec += delta;
	var lifetime_percentage := _lifetime_duration_sec / duration_sec;
	
	if lifetime_percentage > 1.0:
		# instantiate the actor from the scene
		var actor: Node2D = actor_scene_to_spawn.instantiate()
		actor.position = position
		get_parent().add_child(actor)

		# and kill ourselves
		queue_free()
