extends Control

func _ready():
	add_to_group("leaderboard")
	
	# Make this control cover the full screen
	set_anchors_preset(Control.PRESET_FULL_RECT)
	
	# Create background panel
	var panel = ColorRect.new()
	panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	panel.color = Color(0, 0, 0, 0.9)  # Black with 90% opacity
	add_child(panel)
	
	# Create leaderboard label
	var label = Label.new()
	label.name = "LeaderboardLabel"
	label.set_anchors_preset(Control.PRESET_CENTER)
	var font = load("res://PixelCaps!.ttf")
	label.add_theme_font_override("font", font)
	label.position = Vector2(960 - 300, 300)
	label.add_theme_font_size_override("font_size", 56)
	label.add_theme_color_override("font_color", Color.WHITE)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	add_child(label)
	
	# Hide by default
	hide()
