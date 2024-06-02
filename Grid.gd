extends "res://TileMap.gd"

var rng
var map_current=[]
func _input(event):
	var count=0
	if Input.is_action_just_pressed("mb_left"):
		var stats=[[0.01,0.02,0.03,0.02,0.01],[0.02,0.05,0,0.04,0.05],[0.1,0.2,0.3,0.2,0.1],[0.02,0.05,0,0.04,0.05],[0.01,0.02,0.03,0.02,0.01]]
		if(count == 0):
			spread(0.3,3,0.8,1,"E",stats)

func _ready():
	#pass # Replace with function body.
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
			
	print("init grid")
	
	#set_infected(0,0)
	rng = RandomNumberGenerator.new()
	var num = rng.randi_range(0, 265)
	var loop = true
	while loop:
		if map[num/19][num%19]!="r":
			loop=false
			set_infected(num/19, num%19,1)
			map_current[num/19][num%19]=0

func spread(air_per:float, air_distance:int, water_per:float, water_level:int, wind_dir:String, stats):
	
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
		
				if (water_level>0):
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
