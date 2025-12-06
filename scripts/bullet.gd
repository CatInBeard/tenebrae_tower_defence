extends Node2D

class_name Bullet

@export var speed: float = 400.0
@export var max_distance: float = 300
@export var deceleration: float = 50.0
@export var enemy_damage: float = 34.0
@export var delete_after_fit: bool = true

var velocity: Vector2
var traveled_distance: float = 0.0

func _ready() -> void:
	add_to_group("Bullets")

func _physics_process(delta: float) -> void:
	position += velocity * delta
	traveled_distance += velocity.length() * delta

	if velocity.length() > 0:
		var deceleration_vector = velocity.normalized() * deceleration * delta
		velocity -= deceleration_vector
		
	else:
		if traveled_distance >= max_distance or velocity.length() == 0:
			destroy()

func destroy() -> void:
	queue_free()

func set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity
	rotation = velocity.angle() + PI / 2

func get_damage() -> float:
	return enemy_damage
	
func destroy_on_hit():
	if delete_after_fit:
		destroy()
