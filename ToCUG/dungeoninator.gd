extends Node2D
## Aha! I've caught you in my trap Perry the Platypus! I've trapped you in an eternal maze with my Dungeon-inator!

@export var RoomScene: PackedScene
var grid = {} ## dictionary to keep track of room positions
var rooms = []

func _ready():
	generate_dungeon(Vector2(0,0), 20) ## generate a dungeon with (start position, # of rooms to generate)
	#generate_dungeon(rooms[randi() % rooms.size()].get_position(), 10) ## some testing
	mark_room_centers()
	#print(str(grid))

## returns true if generated structure is within the given bound limits, false otherwise
func is_in_bounds(x, y, width, height):
	return 0 <= x and x < width and 0 <= y and y < height

##  gets valid neighbor room positions (EMPTY NEIGHBORING POSITIONS)
func get_neighbors(room):
	var directions = [Vector2(0,1), Vector2(1,0), Vector2(0,-1), Vector2(-1,0)] ## down, right, up, left, in order
	var neighbors = [] ## array that will hold available neighbors of the current room
	## check if there is available space in all 4 axis, then returns an array of Vector2's of available ones
	for direction in directions:
		var nx = room.x + direction.x
		var ny = room.y + direction.y
		if is_in_bounds(nx, ny, 10, 10) and not grid.has (Vector2(nx, ny)):
			neighbors.append(Vector2(nx, ny))
	return neighbors
		

## Dungeon generation black magic
func generate_dungeon(start_pos, num_rooms):
	## initialize the starting room
	var start_room = RoomScene.instantiate()
	#start_room._init(start_pos.x, start_pos.y) ## this doesn't work cuz of .instantiate()
	start_room.x = start_pos.x ## | these are here to replace the above
	start_room.y = start_pos.y ## | amogus
	grid[start_pos] = start_room
	rooms.append(start_room)
	add_child(start_room)
	
	var stack = [start_room]
	
	## black magic room generation
	while stack.size() > 0 and rooms.size() < num_rooms:
		var current_room = stack[stack.size() - 1]
		var neighbors = get_neighbors(current_room) ## get possible neighboring spots from current room
		if neighbors.size() > 0: ## if there's any available neighboring spots...
			var next_pos = neighbors[randi() % neighbors.size()] ## pick a random neighbor
			var next_room = RoomScene.instantiate()
			#next_room._init(next_pos.x, next_pos.y) # this doesn't work cuz of .instantiate()
			next_room.x = next_pos.x ## | these are here to replace the above
			next_room.y = next_pos.y ## | amogus 2
			grid[next_pos] = next_room
			rooms.append(next_room)
			add_child(next_room)
			current_room.connected_rooms.append(next_room)
			next_room.connected_rooms.append(current_room)
			stack.append(next_room)
		else:
			stack.pop_back()

# connects up rooms after generate_dungeon creates them
func mark_room_centers():
	## initialize tile coordinate variables
	var room_center: Vector2 ## tile coordinates of the center of the room locally to self
	var room_origin_position: Vector2 ## tile coordinates of upper left corner of room
	var room_center_position: Vector2 ## tile coordinates of room center in the world
	var connected_room_center: Vector2  ## tile coordinates of the center of the connected room locally to self
	var connected_room_origin_position: Vector2 ## tile coordinates of upper left corner of connected room
	var connected_room_center_position: Vector2 ## tile coordinates of the center of the connected room in the world
	
	## pseudocode of the solution
	##for every room:
		##for every connected room:
			##if center of both rooms are horizontal to each other
				##for range room1.x to room2.x, add a hallway tile
			##if center of both rooms are vertical to each other
				##for range room1.y to room2.y, add a hallway tile
	
	for room in rooms:
		var tile_map = room.get_node("TileMap")
		room_center = Vector2(room.get_room_tile_width()/2, room.get_room_tile_length()/2)
		## get the upper left tile position of the room based on grid position multiplied by room size
		room_origin_position =  Vector2(room.x, room.y) * Vector2(room.get_room_tile_width(), room.get_room_tile_length())
		room_center_position = room_origin_position + room_center
		#print("origin" + str(room_origin_position))
		#print("center" + str(room_center_position))
		tile_map.set_cell(0, room_center, 0, Vector2(3,0)) ## why does room_center work but not room_center_position ?
		for c_room in room.connected_rooms:
			connected_room_center = Vector2(c_room.get_room_tile_width()/2, c_room.get_room_tile_length()/2)
			connected_room_origin_position =  Vector2(c_room.x, c_room.y) * Vector2(c_room.get_room_tile_width(), c_room.get_room_tile_length())
			connected_room_center_position = room_origin_position + room_center
			if room_center_position.y == connected_room_center_position.y:
				for x in range (room_center_position.x, connected_room_center_position.x):
					tile_map.set_cell(0, x, 0, Vector2(3,0)) ## ok, set_cell is not working in the way I think its supposed to, consult for ideas later
	
	#for room in rooms:
		#var tile_map = room.get_node("TileMap")
		# get the center point of the room, then draw a path of walkable tiles to the centerpo int of adjacent rooms
		#room_center = Vector2(room.getRoomWidth()/2, room.getRoomLength()/2) # get the center of the room
		#room_center_position = room.position + room_center # find the world coordinate positions of the center of the room
		#tile_map.set_cell(0, room_center, 0, Vector2(3,0))
		#for connected_room in room.connected_rooms:
			#connected_room_center = Vector2(connected_room.getRoomWidth()/2, connected_room.getRoomLength()/2) # get the center of the room
			#connected_room_center_position = connected_room.position + connected_room_center # find the world coordinate positions of the center of the room
			#if room_center_position.x == connected_room_center_position.x:
				#for y in range(room_center_position.y/16, connected_room_center_position.y/16):
					#tile_map.set_cell(0, Vector2(room_center_position.x/16, y), 0, Vector2(3,0))
					#print(str(Vector2(room_center_position.x,y)))
			#if room_center_position.y == connected_room_center_position.y:
				#for x in range(room_center_position.x/16, connected_room_center_position.x/16):
					#tile_map.set_cell(0, Vector2(x, room_center_position.y /16), 0, Vector2(3,0))
					#print(str(Vector2(x, room_center_position.y)))
