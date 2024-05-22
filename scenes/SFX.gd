extends HSlider


# Called when the node enters the scene tree for the first time.
@export
var bus_name = "SFX"

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	value = 1

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
