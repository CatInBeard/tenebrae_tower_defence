extends Node2D

@export var bullet_scene: PackedScene
@export var fire_rate: float = 1.0

var can_shoot: bool = true
var enemy_queue: Array = []

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		if not enemy_queue.has(area.get_parent()):
			enemy_queue.append(area.get_parent())
		if can_shoot:
			start_shooting()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		enemy_queue.erase(area.get_parent())

func start_shooting() -> void:
	can_shoot = false
	await get_tree().create_timer(1.0 / fire_rate).timeout
	while enemy_queue.size() > 0:
		shoot(enemy_queue[0].position)
		await get_tree().create_timer(1.0 / fire_rate).timeout
	can_shoot = true

func shoot(target_position: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = position

	var direction = (target_position - position).normalized()
	bullet.set_velocity(direction * bullet.speed)

	get_parent().add_child(bullet)
