extends Node2D

const NIGHT = 0
const MAP = 1
const REPORT = 2 

var day = 0
var phase = NIGHT

const NIGHT_POS = Vector2i(576, 1200)
const MAP_POS = Vector2i(576, 324)
const REPORT_POS = Vector2i(576, 2000)

func _ready():
	get_node("Camera2D").position = NIGHT_POS


func _input(_event):
	if Input.is_action_just_pressed("mb_left"):
		if phase != NIGHT:
			phase_switch()


func _on_night_confirm_pressed():
	# check if is the correct amount of skill
	if search_tree_for_check_marks() == 1:
		phase_switch()


#func night_phase_prep():
	#if day == 1:
		#pass
	#if day == 2:
		#pass
	#else:
		#pass


func phase_switch():
	if phase == NIGHT:
		# lock skills in
		lock()
		# add skill to virus.gd (rebuild all skills)
		add_skill()
		Virus.update_rate_grid()
		Grid.spread(Virus.air_rate, Virus.air_dist, Virus.water_rate, Virus.water, Virus.wind_dir, Virus.rate_grid)
		get_node("Camera2D").position = MAP_POS
		phase = MAP
	elif phase == MAP:
		
		get_node("Camera2D").position = REPORT_POS
		phase = REPORT
	elif phase == REPORT:
		
		get_node("Camera2D").position = NIGHT_POS
		phase = NIGHT


func search_tree_for_check_marks():
	var start = get_node("Night/WeatherSkillHomeNode")
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
	var start = get_node("Night/WeatherSkillHomeNode")
	for c in start.get_children():
		update_weather_child(c)


func update_weather_child(node):
	if node.box_state:
		if node.name == "Water":
			Virus.water = true
			update_weather_further(node)
		elif node.name == "Air":
			Virus.air = true
			update_weather_further(node)
		elif node.name == "Regular":
			Virus.reg = true
			update_weather_further(node)


func update_weather_further(node):
	if node.name == "Water": 
		if node.find_child("RateUp2", true):
			Virus.water_rate = 2
		elif node.find_child("RateUp", false):
			Virus.water_rate = 1
		if node.find_child("DisUp2", true):
			Virus.water_dist = 2
		elif node.find_child("DistUp", false):
			Virus.water_dist = 1
	if node.name == "Air": 
		if node.find_child("RateUp2", true):
			Virus.air_rate = 2
		elif node.find_child("RateUp", false):
			Virus.air_rate = 1
		if node.find_child("DisUp2", true):
			Virus.air_dist = 2
		elif node.find_child("DistUp", false):
			Virus.air_dist = 1
	if node.name == "Regular": 
		if node.find_child("RateUp2", true):
			Virus.reg_rate = 2
		elif node.find_child("RateUp", false):
			Virus.reg_rate = 1
		if node.find_child("DisUp2", true):
			Virus.reg_dist = 2
		elif node.find_child("DistUp", false):
			Virus.reg_dist = 1
