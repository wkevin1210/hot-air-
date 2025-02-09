extends HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(0))
	value_changed.connect(_on_value_changed)

func _on_value_changed(slider: float) -> void: 
	AudioServer.set_bus_volume_db(0, linear_to_db(slider))
