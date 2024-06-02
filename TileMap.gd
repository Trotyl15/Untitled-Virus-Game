extends TileMap

var range = {"l": 10, "r": 28, "c": 4, "f": 17}
var map_dict ={"a": Vector2i(1,1), "b": Vector2i(0,1), "c": Vector2i(2,1), "d": Vector2i(1,0), "e": Vector2i(2,0), "r": Vector2i(0,2), "x": Vector2i(0,0)}
var map_infected=[]
var map
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#
	#get_node("/root/Grid").init_grid()
	

func import_map():
	var file = FileAccess.open("res://map.txt", FileAccess.READ)
	var map_txt = file.get_as_text(true)
	var map_row=map_txt.split("\n").slice(0,-1)
	var map = []
	for x in range (0, map_row.size()):
		map.append(map_row[x].split(""))
	return map
