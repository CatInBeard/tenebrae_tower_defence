extends Node2D

@export var uiSelect: PackedScene = preload("res://scenes/UI/select_area.tscn")
@onready var toolCover: PackedScene = preload("res://scenes/UI/control.tscn")
@export var grid_size: int = 50

var uiSelectInstance: Node2D = null
var uiToolCoverInstance: Node2D = null

func _ready() -> void:
	
	uiSelectInstance = uiSelect.instantiate()
	uiToolCoverInstance = toolCover.instantiate()
	uiToolCoverInstance.SelectArea = uiSelectInstance
	uiToolCoverInstance.Level = self
	
	hide_ui()
	
	add_child(uiSelectInstance)
	add_child(uiToolCoverInstance)
	
	if Input.get_connected_joypads():
		var screen_size = get_viewport().get_size()
		var select_frame_pos = Vector2(int(screen_size.x/2 / grid_size) * grid_size,int(screen_size.y/2 / grid_size) * grid_size)
		move_frame(select_frame_pos)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		move_frame(event.global_position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		hide_ui()
	elif event is InputEventScreenTouch and event.is_pressed():
		move_frame(event.global_position)

func move_frame(position: Vector2) -> void:
	if !uiToolCoverInstance.is_inside(position):
		var grid_x = int(position.x / grid_size) * grid_size + grid_size/2
		var grid_y = int(position.y / grid_size) * grid_size + grid_size/2

		uiSelectInstance.position = Vector2(grid_x, grid_y)
		uiSelectInstance.visible = true
		uiToolCoverInstance.visible = true
	
func hide_ui():
	uiSelectInstance.visible = false
	uiToolCoverInstance.visible = false
