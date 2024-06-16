extends TileMap


		
# Called when the node enters the scene tree for the first time.
func _ready():
	#print(DaysAndNights.day)
	#DaysAndNights.day_increment()
	if(DaysAndNights.day == 0):
		set_map()
	else:
		var stats = [[0.1,0.2,0.3,0.2,0.1],[0.0,0.5,0,0.4,0.5],[0.1,0.2,0.3,0.2,0.1],[0.2,0.5,0,0.4,0.5],[0.1,0.2,0.3,0.2,0.1]]
		spread(0.02, 2, 0.03, 1, "N", stats)
		show_map()
		
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

func show_map():
	for x in range (Map.range["c"], Map.range["f"]+1):
		for y in range (Map.range["l"], Map.range["r"]+1):
			if(Map.map_infected[x-Map.range["c"]][y-Map.range["l"]]==1):
				set_cell(0,Vector2(y,x), 0, Map.map_dict["x"], 0)
			else:
				set_cell(0,Vector2(y,x), 0, Map.map_dict[Map.map[x-Map.range["c"]][y-Map.range["l"]]], 0)
			

			
func set_map():
	Map.map = import_map()
	#print(Map.map)
	for x in range (Map.range["c"], Map.range["f"]+1):
		for y in range (Map.range["l"], Map.range["r"]+1):
			set_cell(0,Vector2(y,x), 0, Map.map_dict[Map.map[x-Map.range["c"]][y-Map.range["l"]]], 0)
			
	for x in range (0, 14):
		Map.map_infected.append([])
		Map.map_current.append([])
		for y in range (0,19):
			Map.map_infected[x].append(0)
			Map.map_current[x].append(0)
	
	Map.rng = RandomNumberGenerator.new()
	var loop = true
	while loop:
		var num = Map.rng.randi_range(0, 265)
		if Map.map[num/19][num%19]!="r":
			loop=false
			set_infected(num/19, num%19,1)
			Map.map_current[num/19][num%19]=0
			print(num)
			set_cell(-1, Vector2(num%19+10, num/19+4), 0, Map.map_dict["x"], 0)
			Map.infected_count = Map.infected_count+1
			


		

func spread(air_per:float, air_distance:int, water_per:float, water_upgrade:bool, wind_dir:String, stats):
	#print(stats)
	for x in range (0, 14):
		for y in range (0, 19):
			#print("spread")
			if(Map.map_infected[x][y] && Map.map_current[x][y]==0):
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
					if(y+1<19&&Map.map[x][y+1]=="r"):
						set_infected(x, y+4, water_per)
					elif(y-1>=0&&Map.map[x][y-1]=="r"):
						set_infected(x, y-4, water_per)
	
			
	for x in range (0, 14):
		for y in range (0, 19):
			Map.map_current[x][y]=0
	


func set_infected(row:int, col:int, percentage:float):
	#print(percentage)
	if(row<0||row>=14||col<0||col>=19||Map.rng.randf()>percentage||Map.map_infected[row][col]==1||Map.map[row][col]=="r"):
		return
	Map.map_infected[row][col]=1
	Map.map_current[row][col]=1
	Map.infected_count = Map.infected_count+1
	#set_cell(-1, Vector2(col+10, row+4), 0, map_dict["x"], 0)

func cure_infected(row:int, col:int):
	Map.map_infected[row][col]=0
	#set_cell(0, Vector2(col+10, row+4), 0, map_dict[map[row][col]], 0)
