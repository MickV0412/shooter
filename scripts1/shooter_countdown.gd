extends Label

func _ready():
	add_to_group("countdown")
	
	# Center on screen
	position = Vector2(960, 540)
	
	# Make it big and visible
	add_theme_font_size_override("font_size", 128)
	var font = load("res://PixelCaps!.ttf")
	add_theme_font_override("font", font)
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	add_theme_color_override("font_color", Color.LIME_GREEN)
	add_theme_color_override("font_outline_color", Color.BLACK)
	add_theme_constant_override("outline_size", 10)
	
	# Hide by default
	hide()
