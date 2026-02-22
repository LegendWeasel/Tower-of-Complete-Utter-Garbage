extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates a projectile from a request then calls spawn_projectile
func process_fire_request(request) -> void:
	# Creates the base proj(s) and apply baseline stats
	
	# Apply modifiers from inventory items
	
	# Calls the function to create the projectile in the world
	pass

func spawn_projectile(projectile) -> void:
	# Instanciates all/the proj. into the main scene
	pass
