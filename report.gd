extends Node2D

@onready var bg = $Background
@onready var map = $Map
@onready var report = $Report

# Called when the node enters the scene tree for the first time.
func _ready():
	if(DaysAndNights.map):
		$TileMap.visible = true
	else:
		$TileMap.visible = false
		if(DaysAndNights.day==0):
			print(DaysAndNights.day)
			DialogueManager.show_dialogue_balloon(load("res://Main.dialogue"), "day0")
		else:
			report.texture = load("res://src/reports/"+str(DaysAndNights.weather)+".png")
			DialogueManager.show_dialogue_balloon(load("res://Main.dialogue"), DaysAndNights.weather)

func show_map():
	$TileMap.visible = true
	print("virus")
	DialogueManager.show_dialogue_balloon(load("res://Main.dialogue"), "virus_report")
	
func _input(event):
	#print(DaysAndNights.dialogue_on)
	if Input.is_action_just_pressed("mb_left"): # CHANGE
		if (!DaysAndNights.dialogue_on):
			DaysAndNights.day_increment()
			get_tree().change_scene_to_file("res://skill_tree.tscn")
			DaysAndNights.dialogue_on = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bg.texture = load("res://src/backgrounds/bg"+str(DaysAndNights.bg_num)+".png")
	if(DaysAndNights.map):
		show_map()
		DaysAndNights.map = false
	pass
