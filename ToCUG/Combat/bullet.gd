extends Area2D

var speed = 700.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += transform.x * speed * delta

func die():
	self.queue_free()
