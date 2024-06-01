extends Node2D

var day = 0

const NIGHT_POS = Vector2(576, 324)
const MAP_POS = Vector2(576, 1200)
const WEATHER_POS = Vector2(576, 2000)

func _ready():
	get_node("Camera2D").position = NIGHT_POS


func _on_night_confirm_pressed():
	# check if is the correct amount of skill
	# lock skills in
	# add skill to virus.gd (rebuild all skills)
	get_node("Camera2D").position = MAP_POS


func night_phase_prep():
	if day == 1:
		pass
	if day == 2:
		pass
	else:
		pass


func day_phase():
	# infect 
	# show stuff
	print("daying")
	day_end()


func day_end():
# increase day counter
# move camera
	get_node("Camera2D").position = NIGHT_POS





func _on_button_pressed():
	get_node("Camera2D").position = NIGHT_POS

