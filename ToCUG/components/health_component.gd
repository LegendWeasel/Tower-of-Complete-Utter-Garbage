extends Node2D

signal health_changed
signal died

@export var max_health: float
@export var current_health: float
var is_dead: bool = false

#@export_range(0,100) var current_health: float
#@export_file("*.gd") var f // example of 
#emit_signal("health_changed")
#health_changed.emit(max_health)

func set_max_health(health: float):
	max_health = health
func initialize_health(health: float):
	current_health = max_health

func take_damage(damage: float):
	current_health -= damage
	current_health = clamp(current_health-damage, 0, max_health) # limits health between 0 and max hp
	emit_signal("health_changed")
	if !is_dead and current_health <= 0:
		is_dead = true
		emit_signal("died")

func heal(heal: float):
	take_damage(-heal) # healing is just negative damage
