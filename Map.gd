extends Node

var map = []
var map_current=[]
var clickable = 0
var range = {"l": 10, "r": 28, "c": 4, "f": 17}
var map_dict ={"a": Vector2i(1,1), "b": Vector2i(0,1), "c": Vector2i(2,1), "d": Vector2i(1,0), "e": Vector2i(2,0), "r": Vector2i(0,2), "x": Vector2i(0,0)}
var map_infected=[]
var rng
var infected_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
