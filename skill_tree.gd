extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(DaysAndNights.day==0):
		DialogueManager.show_dialogue_balloon(load("res://Main.dialogue"), "skill_tree")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_confirm_pressed():
	DaysAndNights.skill_confirmed()
