extends CharacterBody2D

#@export var bullet: PackedScene
var bullet = preload("res://bullet.tscn")
#@onready var bullet = get_node("bullet")
const SPEED = 300.0
const INVINCIBILITY_PERIOD = 3 # how long player is invincible after taking damage etc
var health = 3
var taking_damage = false
var current_invincibility_time = 0 # current invincibility time in seconds
var second_counter = 0 # tbh this variable is awful, its basically just for counting when delta == amount of second
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var horizontal_direction
var vertical_direction
var direction = Vector2.ZERO

func _physics_process(delta):
	get_input()
	if taking_damage == true:
		take_damage(delta)
		if current_invincibility_time <= 0:
			current_invincibility_time = INVINCIBILITY_PERIOD # counter for when invuln period ends
	invincibility_countdown(delta)
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

# takes damage when invincibility timer has counted down
func take_damage(delta):
	if current_invincibility_time <= 0:
		health -= 1
		print(str(health))
		#death code here

# count down invincibility time until it hits 0
func invincibility_countdown(delta):
	#print(str(current_invincibility_time))
	if current_invincibility_time >= 0:
		current_invincibility_time -= delta


func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy"):
		taking_damage = true


func _on_hurtbox_body_exited(body):
	if body.is_in_group("Enemy"):
		taking_damage = false
