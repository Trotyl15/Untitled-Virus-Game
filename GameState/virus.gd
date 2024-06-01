# the skill tree of the virus

extends Node

var air_rate = 0
var air_dist = 0
var water_rate = 0
var water_dist = 0
var reg_rate = 0
var reg_dist = 0

var air_dir = "N"

var rate_grid = []

# 0 - 100 percentage
const BASE_RATE = 30

func _ready():
	for x in range(5):
		rate_grid.append([])
		for y in range(5):
			rate_grid.append(int(0)) # 0%
