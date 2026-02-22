extends Resource
class_name FireRequest

@export var owner_id: int # UID of proj. owner
@export var team_id: int #Group Id of proj. team 
@export var source: Vector2 # Starting position of proj.
@export var aim_direction: Vector2 # Normalized vector pointing towards target
@export var base_projectile: projectile_def # basic projectile data
@export var modifiers: Array[Resource] # List of all mods applying to proj.

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
