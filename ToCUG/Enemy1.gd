extends CharacterBody2D


const SPEED = 100.0
var detects_player = false # checks to see if self sees player
var direction # will be a vector pointing from self to player
@onready var player = get_tree().get_nodes_in_group("Player")[0] # get player node from group for detection + movement

func _physics_process(delta):
	
	# Get the vector of direction and handle the movement/deceleration.
	if detects_player == true:
		direction = player.translation - self.translation
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Sight detection radius of the enemy in regards to seeing the Player (entering)
func _on_player_detection_area_entered(area):
	if area.is_in_group("Player"):
		detects_player = true

# Sight detection radius of the enemy in regards to seeing the Player (exiting)
func _on_player_detection_area_exited(area):
	if area.is_in_group("Player"):
		detects_player = false
