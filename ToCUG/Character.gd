extends CharacterBody2D

# 
var max_health: float = 100
var current_health: float

var speed: float

var attack_power: int

var status_effects: Array = []

func _init(max_health: int, speed: float, attack_power: int,):
	self.max_health = max_health
	self.speed = speed
	self.attack_power = attack_power

func move(direction: Vector2, delta: float):
	velocity = direction.normalized() * speed
	
func take_damage(damage: float):
	
	# Apply damage reduction modifiers
	# Currently none
	
	# Applies damage but limits healths between 0 and its max
	current_health = clamp(current_health - damage, 0, max_health) 
	
	# Character dies at 0 health
	if current_health == 0:
		die()

# Deletes the character on death
# Override for speical death
func die():
	pass
	

func _process(delta):
	move_and_slide()
