# the skill tree of the virus

extends Node

var air = false
var water = false
var reg = false

var air_rate = 0
var air_dist = 0
var water_rate = 0
var water_dist = 0
var reg_rate = 0
var reg_dist = 0

var wind_dir = "N"

var rate_grid = []

var direction = {
	"N": Vector2i.UP,
	"W": Vector2i.LEFT,
	"S": Vector2i.DOWN,
	"E": Vector2i.RIGHT,
}
# 0 - 100 percentage
const BASE_CHANCE = 0.3

func _ready():
	for x in range(5):
		rate_grid.append([])
		for y in range(5):
			rate_grid[x].append(float(0)) # 0%


func update_rate_grid():
	var air_chance = BASE_CHANCE * (air_rate * 0.2 + 1)
	var water_chance = BASE_CHANCE * (water_rate * 0.2 + 1)
	var reg_chance = BASE_CHANCE * (reg_rate * 0.2 + 1)
	
	var dir = direction[wind_dir]
	var r_dir = Vector2i(dir.y, dir.x)
	
	if air:
		for x in range(5):
			for y in range(5):
				if abs(x - 2) + abs(y - 2) == 1:
					rate_grid[x][y] += air_chance * 1/3
				if Vector2i(x - 2, y - 2) == dir + r_dir:
					rate_grid[x][y] += air_chance * 1/3
				if Vector2i(x - 2, y - 2) == dir - r_dir:
					rate_grid[x][y] += air_chance * 1/3
				if Vector2i(x - 2, y - 2) == dir:
					rate_grid[x][y] += air_chance * 1/2
				if Vector2i(x - 2, y - 2) == 2 * dir + r_dir:
					rate_grid[x][y] += air_chance * 1/2
				if Vector2i(x - 2, y - 2) == 2 * dir - r_dir:
					rate_grid[x][y] += air_chance * 1/2
				if Vector2i(x - 2, y - 2) == 2 * dir:
					rate_grid[x][y] += air_chance * 1/2
					
	
	# water?
	
	if reg:
		for x in range(5):
			for y in range(5):
				if abs(x - 2) + abs(y - 2) == 1:
					rate_grid[x][y] += reg_chance
				elif abs(x - 2) == 1 and abs(y - 2) == 1:
					if reg_dist == 0:
						rate_grid[x][y] += reg_chance * 1/2
					else:
						rate_grid[x][y] += reg_chance * 3/4
				elif x == 2 and (y == 0 or y == 4):
					if reg_dist == 1:
						rate_grid[x][y] += reg_chance * 1/2
					if reg_dist == 2:
						rate_grid[x][y] += reg_chance * 3/4
				elif y == 2 and (x == 0 or x == 4):
					if reg_dist == 1:
						rate_grid[x][y] += reg_chance * 1/2
					if reg_dist == 2:
						rate_grid[x][y] += reg_chance * 3/4
				elif abs(x - 2) == 2 and abs(y - 2) == 2:
					if reg_dist == 2:
						rate_grid[x][y] += reg_chance * 1/4
				else:
					if reg_dist == 2:
						rate_grid[x][y] += reg_chance * 1/2
	# yippee! coding at it's finest
