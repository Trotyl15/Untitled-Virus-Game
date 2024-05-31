extends Node2D

var box_length = 10
var rng = RandomNumberGenerator.new()

func _ready():
	queue_redraw()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		Grid.get_tile(rng.randi_range(0, 99), rng.randi_range(0, 99)).infect()
	queue_redraw()


func _draw():
	for x in range(Grid.width):
		for y in range(Grid.height):
			var temp_tile : Tile = Grid.get_tile(x, y)
			if not temp_tile.infected:
				draw_rect(Rect2(x * box_length, y * box_length, box_length, box_length), Color.BLUE)
			else:
				draw_rect(Rect2(x * box_length, y * box_length, box_length, box_length), Color.RED)
					
