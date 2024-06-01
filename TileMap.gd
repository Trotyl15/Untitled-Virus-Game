extends TileMap

var range = {"l": 10, "r": 28, "c": 4, "f": 17}
var map_dict ={"a": Vector2i(1,1), "b": Vector2i(0,1), "c": Vector2i(2,1), "d": Vector2i(1,0), "e": Vector2i(2,0), "r": Vector2i(0,2), "x": Vector2i(0,0)}

func _ready():
	var map = import_map()
	for x in range (range["c"], range["f"]+1):
		for y in range (range["l"], range["r"]+1):
			set_cell(0,Vector2(y,x), 0, map_dict[map[x-range["c"]][y-range["l"]]], 0)
			

func next_round(virus: int, weather: int, level: int):
	print(virus)

func import_map():
	var file = FileAccess.open("res://map.txt", FileAccess.READ)
	var map_txt = file.get_as_text(true)
	var map_row=map_txt.split("\n").slice(0,-1)
	var map = []
	for x in range (0, map_row.size()):
		map.append(map_row[x].split(""))
	return map
