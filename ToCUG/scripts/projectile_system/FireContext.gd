extends RefCounted
class_name FireContext
# 2nd Step of bullet creation
# Holds information of how to execute the request.
# 1. Holds all unique spawn information
# 2. Adds active modifiers (ones that remain active after spawned)

#var request : FireRequest
var spawn_requests: Array[ProjectileSpawnBlueprint] = []
var active_projectile_modifiers: Array[ProjectileModifier] = []

func _init(request: FireRequest) -> void:
	#request = p_request
	
	# Creates the base spawn on init
	add_spawn(request)

# Takes 
func add_spawn(req: FireRequest):
	var spawn = ProjectileSpawnBlueprint.new()
	spawn.origin = req.source
	spawn.direction = req.aim_direction
	spawn.modifiers = req.modifiers
	spawn.owner_id = req.owner_id
	spawn.speed = req.base_projectile.base_speed
	spawn.team_id = req.team_id
	spawn_requests.append(spawn)

func register_projectile_modifers(mod: ProjectileModifier):
	active_projectile_modifiers.append(mod)
