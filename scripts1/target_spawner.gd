extends Node2D

@export var alien_scene: PackedScene
@export var spawn_interval = 1.0  # Time between alien spawns

var is_active = false

func _ready():
	add_to_group("target_spawner")

func start_spawning():
	is_active = true
	spawn_alien()

func stop_spawning():
	is_active = false
	# Clear all existing aliens
	for child in get_children():
		if child is Area2D:
			child.queue_free()

func spawn_alien():
	if not is_active:
		return
	
	if alien_scene == null:
		print("ERROR: Alien scene not assigned!")
		return
	
	# Create new alien
	var alien = alien_scene.instantiate()
	add_child(alien)
	
	# Connect to score when hit
	alien.target_hit.connect(_on_target_hit)
	
	# Schedule next spawn
	await get_tree().create_timer(spawn_interval).timeout
	spawn_alien()

func _on_target_hit():
	# Notify game manager
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	if game_manager and game_manager.has_method("on_target_hit"):
		game_manager.on_target_hit()
