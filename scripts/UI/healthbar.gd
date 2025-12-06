extends Node2D

@export var healthSource: Node2D
@export var hideOnFull: bool = true

var progress_bar: TextureProgressBar

func _ready() -> void:
	progress_bar = $TextureProgressBar
	update()

func _process(delta: float) -> void:
	update()

func update():
	if healthSource:
		var value = float(healthSource.health) / float(healthSource.maxHealth) * 100.0
		progress_bar.set_value(value)
		if hideOnFull and value >= 100:
			progress_bar.visible = false
		else:
			progress_bar.visible = true
