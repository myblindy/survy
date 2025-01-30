class_name NodeTimer

@export var interval_sec := 1.0
var _time_sec := 0.0

signal timeout

func process(delta_sec: float) -> void:
    if _time_sec < 1.5:
        _time_sec += delta_sec

        while _time_sec >= interval_sec:
            _time_sec -= interval_sec
            timeout.emit()