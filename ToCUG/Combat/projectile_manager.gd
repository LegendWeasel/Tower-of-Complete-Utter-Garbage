extends Node

func _init() -> void:
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connects to all shooters
	add_to_group("projectile_manager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_shooter_fire_request(req: FireRequest) -> void:
	print(str(req.owner_id) + " just fired")

# Creates a projectile from a request then calls spawn_projectile
func process_fire_request(request) -> void:
	# Creates the base proj(s) and apply baseline stats
	
	# Apply modifiers from inventory items
	
	# Calls the function to create the projectile in the world
	pass

func spawn_projectile(projectile) -> void:
	# Instanciates all/the proj. into the main scene
	pass
