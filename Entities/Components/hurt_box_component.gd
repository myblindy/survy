extends Area2D

@export var health_component: HealthComponent

var _intersections: Array[HitBoxComponent] = []

func _on_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		_intersections.append(area)

func _on_area_exited(area: Area2D) -> void:
	_intersections.erase(area)
		
func _process(delta: float) -> void:
	for intersection in _intersections:	
		if health_component:
			health_component.take_damage(intersection.get_damage(get_parent()))
