extends TextureRect

@onready var box = get_node("CheckBox")


func _process(_delta):
	print(box.button_pressed)
	if not get_parent().box_state():
		box.button_pressed = false


func _on_check_box_toggled(toggled_on):
	print(box.button_pressed)


func box_state():
	return box.button_pressed
