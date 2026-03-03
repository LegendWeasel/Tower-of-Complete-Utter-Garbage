extends Node

 #Directory of where projectiles will be stored at run time
#@export var projectile_container: NodePath

func _init() -> void:
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connects to all shooters
	add_to_group("projectile_manager")
	#projectile_container = NodePath("Projectiles")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates a projectile from a request then calls spawn_projectile
func _on_shooter_fire_request(req: FireRequest) -> void:
	print(str(req.owner_id) + " just fired")
	
	if req.base_projectile == null:
		push_warning("Base projectile not assigned")
		return
	
	var context = FireContext.new(req)
	for modifier in req.modifiers:
		modifier.apply()
	# Create the projectiles defined by request
	for spawn_requests in context.spawn_requests:
		var proj = context.request.base_projectile.scene.instantiate() as Projectile
		#var proectile := req.base_projectile.scene.instantiate() as Bullet
		# Instanciates the spawns
		proj.initialize(spawn_requests)
		add_child(proj)
		


#func process_fire_request(req: FireRequest) -> void:
	## Creates the base proj(s) and apply baseline stats
	#var spawns = _build_spawns(req)
	## Apply modifiers from inventory items
	#
	## Calls the function to create the projectile in the world
	#var container = get_node(projectile_container)
	#for spawn in spawns:
		#var def = spawn["projecile_def"]
		#var bullet_scene: PackedScene = def.scene
		#var bullet := bullet_scene.instantiate()

# Takes a fire request and parses it into distince spawn data
# Every spawn will have its independent data
func _build_spawns(req: FireRequest) -> Array:
	
	# TODO For each spawn, apply the modifiers
	var spawns: Array = []
	var spawn := {
		"position" = req.source,
		"direction" = req.aim_direction,
		"owner_id" = req.owner_id,
		"team_id" = req.team_id,
		"projecile_def" = req.base_projectile
	}
	spawns.append(spawn)
	
	return spawns
