extends TileMap

var map
var rng
var map_current=[]
var clickable = 0
var range = {"l": 10, "r": 28, "c": 4, "f": 17}
var map_dict ={"a": Vector2i(1,1), "b": Vector2i(0,1), "c": Vector2i(2,1), "d": Vector2i(1,0), "e": Vector2i(2,0), "r": Vector2i(0,2), "x": Vector2i(0,0)}
var map_infected=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	set_map()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func import_map():
	var file = FileAccess.open("res://src/tiles/map.txt", FileAccess.READ)
	var map_txt = file.get_as_text(true)
	var map_row=map_txt.split("\n").slice(0,-1)
	var map = []
	for x in range (0, map_row.size()):
		map.append(map_row[x].split(""))
	return map

func set_map():
	map = import_map()
	for x in range (range["c"], range["f"]+1):
		for y in range (range["l"], range["r"]+1):
			set_cell(0,Vector2(y,x), 0, map_dict[map[x-range["c"]][y-range["l"]]], 0)
			
	for x in range (0, 14):
		map_infected.append([])
		map_current.append([])
		for y in range (0,19):
			map_infected[x].append(0)
			map_current[x].append(0)

func spread(air_per:float, air_distance:int, water_per:float, water_upgrade:bool, wind_dir:String, stats):
	print(stats)
	for x in range (0, 14):
		for y in range (0, 19):
			#print("spread")
			if(map_infected[x][y] && map_current[x][y]==0):
				set_infected(x-2, y-2, stats[0][0]);
				set_infected(x-2, y-1, stats[0][1]);
				set_infected(x-2, y,stats[0][2]);
				set_infected(x-2, y+1,stats[0][3]);
				set_infected(x-2, y+2,stats[0][4]);
				set_infected(x-1, y-2,stats[1][0]);
				set_infected(x-1, y-1,stats[1][1]);
				set_infected(x-1, y,stats[1][2]);
				set_infected(x-1, y+1, stats[1][3]);
				set_infected(x-1, y+2, stats[1][4]);
				set_infected(x, y-2,stats[2][0]);
				set_infected(x, y-1,stats[2][1]);
				set_infected(x, y+1, stats[2][3]);
				set_infected(x, y+2,stats[2][4]);
				set_infected(x+1, y-2,stats[3][0]);
				set_infected(x+1, y-1,stats[3][1]);
				set_infected(x+1, y,stats[3][2]);
				set_infected(x+1, y+1, stats[3][3]);
				set_infected(x+1, y+2, stats[3][4]);
				set_infected(x+2, y-2,stats[4][0]);
				set_infected(x+2, y-1,stats[4][1]);
				set_infected(x+2, y,stats[4][2]);
				set_infected(x+2, y+1, stats[4][3]);
				set_infected(x+2, y+2, stats[4][4]);
			#print(map_current)
				if(air_distance>1):
					print("wind")
					print(x-1-air_distance)
					match wind_dir:
						"N":
							print("north")
							print(air_per)
							set_infected(x-1-air_distance, y-1, air_per)
							set_infected(x-1-air_distance, y, air_per)
							set_infected(x-1-air_distance, y+1, air_per)
						"E":
							set_infected(x-1, y+1+air_distance, air_per)
							set_infected(x, y+1+air_distance, air_per)
							set_infected(x+1, y+1+air_distance, air_per)
						"S":
							set_infected(x+1+air_distance, y-1, air_per)
							set_infected(x+1-air_distance, y, air_per)
							set_infected(x-1-air_distance, y+1, air_per)
						"W":
							set_infected(x-1, y-1-air_distance, air_per)
							set_infected(x, y-1-air_distance, air_per)
							set_infected(x+1, y-1-air_distance, air_per)
		
				if water_upgrade:
					if(y+1<19&&map[x][y+1]=="r"):
						set_infected(x, y+4, water_per)
					elif(y-1>=0&&map[x][y-1]=="r"):
						set_infected(x, y-4, water_per)
	
			
	for x in range (0, 14):
		for y in range (0, 19):
			map_current[x][y]=0
	


func set_infected(row:int, col:int, percentage:float):
	#print(percentage)
	if(row<0||row>=14||col<0||col>=19||rng.randf()>percentage||map_infected[row][col]==1||map[row][col]=="r"):
		return
	map_infected[row][col]=1
	map_current[row][col]=1
	set_cell(-1, Vector2(col+10, row+4), 0, map_dict["x"], 0)

func cure_infected(row:int, col:int):
	map_infected[row][col]=0
	set_cell(0, Vector2(col+10, row+4), 0, map_dict[map[row][col]], 0)
