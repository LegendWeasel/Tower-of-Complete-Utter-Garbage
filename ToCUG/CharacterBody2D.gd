extends CharacterBody2D

#@export var bullet: PackedScene
var bullet = preload("res://bullet.tscn")
#@onready var bullet = get_node("bullet")
const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var horizontal_direction
var vertical_direction
var direction = Vector2.ZERO

func _physics_process(delta):
	get_input()
	## Add the gravity
	move_and_slide()

func get_input():
	
	# Player movement
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * SPEED
	#print(input_direction)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	# Player Face direction
	look_at(get_global_mouse_position())
	
func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
