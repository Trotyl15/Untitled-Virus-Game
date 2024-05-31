extends Node
class_name Tile

const A = 1
const B = 2
const C = 3

var infected = false
var region


func _init(region = A):
	self.region = region


func infect():
	infected = true


func spread():
	pass
