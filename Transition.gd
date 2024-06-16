extends CanvasLayer

func transition():
	$ColorRect.visible = true
	$AnimationPlayer.play("fade")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(DaysAndNights.tran)
	if(DaysAndNights.tran):
		DaysAndNights.tran=false
		transition()		


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade":
		$ColorRect.visible=false
	pass # Replace with function body.
