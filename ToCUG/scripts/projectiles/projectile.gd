extends Area2D
class_name Projectile

var owner_id: int # UID of proj. owner
var team_id: int #Group Id of proj. team 
var direction: Vector2
var speed: float = 100.0
var lifetime: float = 5.0
var flight_time: float = 0.0
var behaviors: Array[ProjectileBehavior] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _physics_process(delta):
	#position += transform.x * speed * delta

func initialize(spawn_req = ProjectileSpawnBlueprint) -> void:
	owner_id = spawn_req.owner_id
	team_id = spawn_req.team_id
	global_position = spawn_req.origin
	direction = spawn_req.direction
	speed = spawn_req.speed
	lifetime = spawn_req.lifetime

func add_behavior(behavior: ProjectileBehavior) -> void:
	behaviors.append(behavior)
	behavior.on_attach(self)

func _process(delta: float) -> void:
	# We love frame independent movement
	global_position += speed * direction * delta
	flight_time += delta
	
	# Applies all run time behaviors
	for behavior in behaviors:
		behavior.process(self, delta)
	
	# Updates lifespan info
	if flight_time > lifetime:
		die()


func die():
	#self.queue_free()
	print(get_instance_id(), " just died")
