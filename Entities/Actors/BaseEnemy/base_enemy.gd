class_name BaseEnemy
extends BaseActor

var player: Player

func is_enemy() -> bool:
	return true
	
func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
