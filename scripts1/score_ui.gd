extends Label

func _ready():
	add_to_group("score")
	
	# Position at top left
	var font = load("res://PixelCaps!.ttf")  # Adjust path if in fonts folder
	add_theme_font_override("font", font)
	position = Vector2(20, 20)
	add_theme_font_size_override("font_size", 48)
	add_theme_color_override("font_color", Color.LIME_GREEN)
	
	text = "Score: 0"
