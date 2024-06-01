extends Node2D




func _on_confirm_pressed():
	# check if is the correct amount of skill
	# add skill to virus.gd
	get_tree().change_scene_to_file("res://Scenes/day.tscn")
