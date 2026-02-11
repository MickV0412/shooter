extends Area2D

signal target_hit

@export var lifetime = 0.7  # How long alien stays on screen (adjustable in Inspector)

func _ready():
	# Connect mouse input
	input_event.connect(_on_input_event)
	
	# Spawn at random position on screen
	randomize_position()
	
	# Start lifetime timer
	start_lifetime_timer()

func randomize_position():
	# Random position within screen bounds (with margins)
	var screen_size = get_viewport_rect().size
	var random_x = randf_range(100, screen_size.x - 100)
	var random_y = randf_range(100, screen_size.y - 100)
	position = Vector2(random_x, random_y)

func start_lifetime_timer():
	await get_tree().create_timer(lifetime).timeout
	# Alien disappears after lifetime expires (no points)
	queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	# Check if clicked
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		target_hit.emit()
		queue_free()  # Remove target when hit
