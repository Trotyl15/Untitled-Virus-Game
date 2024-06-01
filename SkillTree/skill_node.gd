extends TextureRect

@onready var box = get_node("CheckBox")


func _process(_delta):
	if not get_parent().box_state():
		box.button_pressed = false


func box_state():
	return box.button_pressed
