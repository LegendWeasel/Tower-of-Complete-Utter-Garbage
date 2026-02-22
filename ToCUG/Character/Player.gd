# Player.gd
extends "res://Character/Character.gd"

signal fire_requested

@export var base_proj: projectile_def # Starts as basic_bullet.tres

func _init():
	super._init(100, 200, 1)

func _ready():
	add_to_group("shooters")
	var pm = get_tree().get_first_node_in_group("projectile_manager")
	if pm:
		fire_requested.connect(pm._on_shooter_fire_request)
		print("Connected fire_requested to ProjectileManager")
	else:
		push_warning("No ProjectileManager found to connect to")
func _physics_process(delta):
	get_input()
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton:
		var hitbox = $Anchor/AttackHitbox/CollisionShape2D
		hitbox.disabled = !hitbox.disabled
		
		if Input.is_action_pressed("shoot"):
			var req: FireRequest = FireRequest.new()
			req.owner_id = get_instance_id()
			req.team_id = -1 # TODO Change to working team id
			req.source = global_position
			req.aim_direction = (get_global_mouse_position() - global_position).normalized()
			req.base_projectile = base_proj
			fire_requested.emit(req)
			
func get_input():
	#Player movement	
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * speed


#func _physics_process(delta):
	#get_input()
	#if taking_damage == true:
		#take_damage(delta)
		#if current_invincibility_time <= 0:
			#current_invincibility_time = INVINCIBILITY_PERIOD # counter for when invuln period ends
	#invincibility_countdown(delta)
	### Add the gravity
	#move_and_slide()

#func shoot():
	#var b = bullet.instantiate()
	#owner.add_child(b)
	#b.transform = $Muzzle.global_transform

#takes damage when invincibility timer has counted down
#func take_damage(delta):
	#if current_invincibility_time <= 0:
		#health -= 1
		#print(str(health))
		##death code here

## count down invincibility time until it hits 0
#func invincibility_countdown(delta):
	##print(str(current_invincibility_time))
	#if current_invincibility_time >= 0:
		#current_invincibility_time -= delta


#func _on_hurtbox_body_entered(body):
	#if body.is_in_group("Enemy"):
		#taking_damage = true
#
#
#func _on_hurtbox_body_exited(body):
	#if body.is_in_group("Enemy"):
		#taking_damage = false
#>>>>>>> cc5aa8cbbb5f595e3f3553476bae44d4adaf1b14
