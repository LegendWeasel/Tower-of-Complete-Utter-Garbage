extends CharacterBody2D

# 
var max_health: float = 100
var current_health: float

#var current_invincibility_time: float = 0 # current invincibility time in seconds
var invincibiliy_duration: float 
# Flag to check if player is invincible
var is_invincible = false

# Referance to i-frame timer
@onready var invincibility_timer = $InvincibilityTimer
var timer = Timer.new()

var speed: float

var attack_power: int

var status_effects: Array = []

func _init(max_health: int, speed: float, attack_power: int,):
	self.max_health = max_health
	self.speed = speed
	self.attack_power = attack_power
	
func _ready():
	#invincibility_timer.connect("timeout", self, "_on_invicibility_timeout")
	pass

# Moves character
func move(direction: Vector2, delta: float):
	velocity = direction.normalized() * speed

# Call when the character is taking damage
func take_damage(damage: float):
	# Takes damage only when not in i frames
	if not is_invincible:
		print(str(self) + " got hit")
		# Apply damage reduction modifiers
		# Currently none
		
		# Applies damage but limits healths between 0 and its max
		current_health = clamp(current_health - damage, 0, max_health) 
		
		# Character dies at 0 health
		if current_health <= 0:
			die()
		
		# Start the i frames
		invincibility_timer.start()
		is_invincible = true
	else:
		# Print for debug
		print(str(self) + " is invincible")
		
# Reset invicibility once timer timeouts
func _on_invincibility_timer_timeout():
	is_invincible = false

# Deletes the character on death
# Override for speical death
func die():
	pass

func _process(delta):
	move_and_slide()
