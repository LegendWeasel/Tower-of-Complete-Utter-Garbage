extends Area2D
class_name Projectile

var direction: Vector2
var speed: float = 700.0
var lifetime: float = 5.0
var flight_time: float = 0.0
var behaviors: Array[ProjectileBehavior] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _physics_process(delta):
	#position += transform.x * speed * delta

func initialize(spawn_req = ProjectileSpawnBlueprint) -> void:
	global_position = spawn_req.origin
	direction = spawn_req.direction
	speed = spawn_req.speed
	
	

func _process(delta: float) -> void:
	# We love frame independent movement
	global_position += speed * direction * delta
	
	# Updates lifespan info
	flight_time += delta
	if flight_time > lifetime:
		die()


func die():
	self.queue_free()
