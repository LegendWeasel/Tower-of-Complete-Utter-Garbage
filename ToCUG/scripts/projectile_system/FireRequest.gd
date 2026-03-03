extends RefCounted
class_name FireRequest
# 1st step of bullet creation
# Short-lived data structure that holds all the data needed to
# create a projectile. 1 per "click"

var owner_id: int # UID of proj. owner
var team_id: int #Group Id of proj. team 
var source: Vector2 # Starting position of proj.
var aim_direction: Vector2 # Normalized vector pointing towards target
var speed: float # In pixels per second. Scalar
var lifetime: float# How long bullet is alive for 
var base_projectile: projectile_def # basic projectile data
var modifiers: Array[Resource] # List of all mods applying to proj.
