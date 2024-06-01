extends Node2D

const NIGHT_POS = Vector2(576, 324)
const DAY_POS = Vector2(576, 1200)

func _ready():
	get_node("Camera2D").position = NIGHT_POS


func _on_confirm_pressed():
	# check if is the correct amount of skill
	# add skill to virus.gd (rebuild all skills)
	get_node("Camera2D").position = DAY_POS


func night_phase_prep():
	if Grid.day == 1:
		pass
	if Grid.day == 2:
		pass
	else:
		pass




# func day_end()
# increase day counter
# move camera
