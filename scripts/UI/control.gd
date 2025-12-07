extends Node2D

@export var SelectArea: SelectArea = null
@export var Level: Node2D = null
@export var textureButton: PackedScene = preload("res://scenes/UI/icon.tscn")

@onready var textureRect: TextureRect = $TextureRect 

func _ready():
	center_control()

func _process(delta):
	center_control()
	draw_available()
			
func draw_available():
	var icons = []
	if SelectArea.can_build():
		var available = SelectArea.get_available_build()
		for node in available:
			var props = get_scene_properties(node)
			icons.append(props["icon"])
			
	for icon in icons:
		var button_instance = textureButton.instantiate()
		
		if button_instance is TextureButton:
			button_instance.set_texture_normal(icon)
		button_instance.position = Vector2(-90, -15)
		add_child(button_instance)

func center_control():
	var screen_size = get_viewport_rect().size
	position.x = (screen_size.x) / 2
	position.y = screen_size.y - textureRect.size.y/2-2

var cache: Dictionary = {}

class SceneProperties:
	var cost: int
	var icon: Texture2D

func get_scene_properties(scene: PackedScene) -> Dictionary:
	if scene in cache:
		return cache[scene]
	
	var instance = scene.instantiate()
	var data: Dictionary = {
		"coast": instance.get_coast(),
		"icon": instance.get_icon()
	} 

	cache[scene] = data
	return data
	
func is_inside(point: Vector2) -> bool:
	var position = textureRect.global_position
	var size = textureRect.size
	return Rect2(position, size).has_point(point)
