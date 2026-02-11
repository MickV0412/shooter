extends Node

# Player data
var players = [
	{
		"name": "Robot",
		"score": 0
	},
	{
		"name": "Laika",
		"score": 0
	},
	{
		"name": "Astronaut",
		"score": 0
	}
]

var current_player_index = 0
var game_active = false
var round_time = 30.0
var time_remaining = round_time

# References
var timer_ui
var score_ui
var countdown_label
var leaderboard_ui
var target_spawner
var player_name_label

func _ready():
	add_to_group("game_manager")
	call_deferred("setup_references")

func setup_references():
	timer_ui = get_tree().get_first_node_in_group("timer")
	score_ui = get_tree().get_first_node_in_group("score")
	countdown_label = get_tree().get_first_node_in_group("countdown")
	leaderboard_ui = get_tree().get_first_node_in_group("leaderboard")
	target_spawner = get_tree().get_first_node_in_group("target_spawner")
	player_name_label = get_tree().get_first_node_in_group("player_name")
	
	if leaderboard_ui:
		leaderboard_ui.hide()
	
	# Start first player
	start_countdown()

func _process(delta):
	if game_active:
		time_remaining -= delta
		
		if timer_ui:
			timer_ui.text = "Time: %.1f" % max(0, time_remaining)
		
		if time_remaining <= 0:
			end_round()

func start_countdown():
	# Show which player is next
	if player_name_label:
		player_name_label.text = players[current_player_index]["name"]
		player_name_label.show()
	
	if countdown_label:
		countdown_label.show()
		await countdown_3_2_1()
		countdown_label.hide()
	else:
		await get_tree().create_timer(3.0).timeout
	
	# Hide player name and start round
	if player_name_label:
		player_name_label.hide()
	
	start_round()

func countdown_3_2_1():
	if countdown_label:
		countdown_label.text = "3"
		await get_tree().create_timer(1.0).timeout
		countdown_label.text = "2"
		await get_tree().create_timer(1.0).timeout
		countdown_label.text = "1"
		await get_tree().create_timer(1.0).timeout
		countdown_label.text = "GO!"
		await get_tree().create_timer(0.5).timeout

func start_round():
	game_active = true
	time_remaining = round_time
	
	# Update score display
	if score_ui:
		score_ui.text = "Score: 0"
	
	# Start spawning targets
	if target_spawner and target_spawner.has_method("start_spawning"):
		target_spawner.start_spawning()

func end_round():
	game_active = false
	
	# Stop spawning
	if target_spawner and target_spawner.has_method("stop_spawning"):
		target_spawner.stop_spawning()
	
	print(players[current_player_index]["name"], " finished with score: ", players[current_player_index]["score"])
	
	# Check if this was the last player
	if current_player_index >= players.size() - 1:
		# Game over - show leaderboard
		show_leaderboard()
	else:
		# Next player
		current_player_index += 1
		await get_tree().create_timer(2.0).timeout
		start_countdown()

func on_target_hit():
	if not game_active:
		return
	
	# Increase score
	players[current_player_index]["score"] += 1
	
	# Update score display
	if score_ui:
		score_ui.text = "Score: %d" % players[current_player_index]["score"]
	
	print("Hit! Score: ", players[current_player_index]["score"])

func show_leaderboard():
	# Sort players by score (highest first)
	var sorted_players = players.duplicate()
	sorted_players.sort_custom(func(a, b): return a["score"] > b["score"])
	
	# Show leaderboard UI
	if leaderboard_ui:
		leaderboard_ui.show()
		update_leaderboard_display(sorted_players)

func update_leaderboard_display(sorted_players):
	if leaderboard_ui == null:
		return
	
	var leaderboard_label = leaderboard_ui.get_node_or_null("LeaderboardLabel")
	if leaderboard_label:
		var text = "=== LEADERBOARD ===\n\n"
		for i in range(sorted_players.size()):
			var player = sorted_players[i]
			text += "%d. %s - %d points\n" % [i + 1, player["name"], player["score"]]
		leaderboard_label.text = text
