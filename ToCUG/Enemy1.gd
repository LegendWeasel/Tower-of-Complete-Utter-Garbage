extends CharacterBody2D


const SPEED = 25.0
var health = 3
var detects_player = false # checks to see if self sees player
var direction # will be a vector pointing from self to player
var knockback = Vector2.ZERO
@onready var player = get_tree().get_nodes_in_group("Player")[0] # get player node from group for detection

func _physics_process(delta):
	
	# Get the vector of direction and handle the movement/deceleration.
	if detects_player == true:
		direction = (player.position - self.position).normalized() # get direction vector2
		#print(str(direction))
		velocity = direction * SPEED
		look_at(player.position) # points self towards player
	else: # decelerate to zero if doesn't see player
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	
	if knockback != Vector2.ZERO: # Handles knockback
		velocity = knockback
		knockback = lerp(knockback, Vector2.ZERO, 0.2) # lerps knockback value back to 0,0 over time (roughly)
		if ((knockback - Vector2.ZERO).length() < 10): # deals with floating point errors by setting knockback to 0,0 when its roughly close enough
			knockback = Vector2.ZERO
		print(str(knockback))
	
	
	move_and_slide()

func die(): # does what the function name describes lmao
	self.queue_free()


# Player Detection code
# Sight detection radius of the enemy in regards to seeing the Player (entering)
func _on_player_detection_body_entered(body):
	if body.is_in_group("Player"):
		detects_player = true
		#print("detected")

# Sight detection radius of the enemy in regards to seeing the Player (exiting)
func _on_player_detection_body_exited(body):
	if body.is_in_group("Player"):
		detects_player = false
		#print("undetected")

# Taking damage code (from bullets)
# Take damage whenever a bullet hits you and also add knockback
func _on_hurtbox_area_entered(area):
	if area.is_in_group("Bullet"):
		health -= 1
		area.die() # removes the bullet
		if health <= 0:
			die()
		else: # set knockback
			var knockback_strength = 512
			var direction_from_bullet = area.global_position\
			.direction_to(self.global_position) # create a normalized Vector2 pointing from the bullet to self
			knockback = direction_from_bullet * knockback_strength
