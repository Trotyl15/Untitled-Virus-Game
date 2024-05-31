extends Node

#const Tile = preload("res://Board/tile.gd")

var width = 100
var height = 50
var grid : Array
var rng = RandomNumberGenerator.new()

func _ready():
	var start = Vector2(rng.randi_range(0, width), rng.randi_range(0, height))
	for x in range(width):
		grid.append([])
		for y in range(height):
			if start == Vector2(x, y):
				grid[x].append(Tile.new())
				get_tile(x, y).infect()
			else:
				grid[x].append(Tile.new())


func get_tile(x, y):
	return grid[x][y]


func spread():
	for x in range(width):
		for y in range(height):
			get_tile(x, y).spread()
