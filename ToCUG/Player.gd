# Player.gd
extends "res://Character.gd"

func _init():
	super._init(100, 200, 1)
	
func _physics_process(delta):
	get_input()

func _input(event):
	if event is InputEventMouseButton:
		var hitbox = $Anchor/AttackHitbox/CollisionShape2D
		hitbox.disabled = !hitbox.disabled
			
func get_input():
	#Player movement	
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * speed

	#aiming
	#var aim_distance: float = 150
	#var mouse_location: Vector2 = get_local_mouse_position()
	#var aim_location: Vector2 = mouse_location.normalized() * aim_distance
	#look_at($Anchor/Aim.position)

