extends Label

func _ready():
	add_to_group("player_name")
	
	# Position above countdown
	position = Vector2(960, 300)
	
	var font = load("res://PixelCaps!.ttf")
	add_theme_font_override("font", font)
	# Styling
	add_theme_font_size_override("font_size", 72)
	add_theme_color_override("font_color", Color.LIME_GREEN)
	add_theme_color_override("font_outline_color", Color.LIME_GREEN)
	add_theme_constant_override("outline_size", 4)
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	# Hide by default
	hide()
