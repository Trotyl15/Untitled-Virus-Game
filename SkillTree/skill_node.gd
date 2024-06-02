extends TextureRect
class_name SkillNode

@onready var box = get_node("CheckBox")
var locked = false

func _process(_delta):
	if not get_parent().box_state():
		box.button_pressed = false


func box_state():
	if is_instance_valid(box):
		return box.button_pressed
	else:
		return true


func lock_in():
	get_node("ColorRect").queue_free()
	locked = true
	box.queue_free()


func _on_check_box_toggled(toggled_on):
	get_node("ColorRect").visible = not get_node("ColorRect").visible


func is_locked():
	return locked
