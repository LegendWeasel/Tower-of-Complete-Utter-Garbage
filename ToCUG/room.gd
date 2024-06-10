extends Node2D

var x: int # these are x and y values on the grid in dungeoninator, NOT x and y position values
var y: int
var connected_rooms = []
var gap_size = 30 ## The size of the gap between rooms

#func _init(x,y): # doesn't work with .instantiate() anymore in the dungeoninator script
	#self.x = x
	#self.y = y
	#self.connected_rooms = []

func _ready():
	self.position.x = x * get_room_tile_width() * gap_size
	self.position.y = y * get_room_tile_length() * gap_size
	

func get_room_tile_length():
	return get_node("TileMap").get_used_rect().size.x

func get_room_tile_width():
	return get_node("TileMap").get_used_rect().size.y
