extends Label

func _ready():
	add_to_group("timer")
	
	# Position at top center
	var font = load("res://PixelCaps!.ttf")
	add_theme_font_override("font", font)
	position = Vector2(960 - 100, 20)
	add_theme_font_size_override("font_size", 48)
	add_theme_color_override("font_color", Color.WHITE)
	add_theme_color_override("font_outline_color", Color.BLACK)
	add_theme_constant_override("outline_size", 10)
	
	text = "Time: 30.0"
