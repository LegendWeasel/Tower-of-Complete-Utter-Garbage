extends Node2D

var x: int # these are x and y values on the grid in dungeoninator, NOT x and y position values
var y: int
var connected_rooms = []

#func _init(x,y): # doesn't work with .instantiate() anymore in the dungeoninator script
	#self.x = x
	#self.y = y
	#self.connected_rooms = []

func _ready():
	self.position.x = x * 16 * 30
	self.position.y = y * 16 * 30
	#print(str(get_child(0).get_used_rect().size))
	

func getPosition():
	return Vector2(self.position.x, self.position.y)

func getRoomLength():
	return get_node("TileMap").get_used_rect().size.x

func getRoomWidth():
	return get_node("TileMap").get_used_rect().size.y
