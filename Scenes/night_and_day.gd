extends Node2D

var day = 0

const NIGHT_POS = Vector2i(576, 1200)
const MAP_POS = Vector2i(576, 324)
const WEATHER_POS = Vector2i(576, 2000)

func _ready():
	get_node("Camera2D").position = NIGHT_POS


func _on_night_confirm_pressed():
	# check if is the correct amount of skill
	if search_tree_for_check_marks() == 1:
		# lock skills in
		lock()
		# add skill to virus.gd (rebuild all skills)
		add_skill()
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


func search_tree_for_check_marks():
	var start = get_node("Night/HomeNode")
	return search_children(start)


func search_children(node):
	var children = node.get_children()
	var n = 0
	for c in children:
		if c is SkillNode:
			n += search_children(c)
	if node.box_state() and not node.is_locked():
		n += 1
	return n


func lock():
	var start = get_node("Night/WeatherSkillHomeNode")
	lock_helper(start)


func lock_helper(node):
	var children = node.get_children()
	for c in children:
		if c is SkillNode and c.box_state():
			if not c.is_locked():
				c.lock_in()
			lock_helper(c)


func add_skill():
	add_weather_skill()


func add_weather_skill():
	pass
