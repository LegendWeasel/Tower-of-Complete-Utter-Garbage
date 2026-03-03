extends RefCounted
class_name ProjectileSpawnBlueprint
# 3rd Step of bullet creation
# Holds the data to instanciate 1 bullet instance

var owner_id: int # UID of proj. owner
var team_id: int #Group Id of proj. team 
var origin: Vector2  # Spawn location of projectile
var direction : Vector2 # Normalized direction of proj
var speed : float # Final speed of proj
var lifetime: float # Seconds of lifespan
var modifiers: Array[ProjectileModifier] # List of all mods applying to proj.
var proj_scene: PackedScene # Scene in which to instanciate bullet
# Only modifiers can add tags
var tags: Array[StringName] # tags that easily define game properties, ie physical
