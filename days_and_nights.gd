extends Node

var day = 0
var last_day = 3
var air_dirs = ["N","E","S","W"]
var air_dir
var rng = RandomNumberGenerator.new()
var bg_num = 1
var map = false
var weather
var weather_dict = ["sunny", "windy", "rainy"]
var dialogue_on = true
var tran = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func transition():
	print("transit")
	tran = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func day_increment():
	day = day + 1
	
func show_map():
	map=true

func skill_confirmed():
	air_dir=air_dirs[rng.randi_range(0,3)]
	bg_num = int(Map.infected_count/57)+1
	#print(day)
	#print(bg_num)
	weather=weather_dict[rng.randi_range(0,2)]
	get_tree().change_scene_to_file("res://report.tscn")
