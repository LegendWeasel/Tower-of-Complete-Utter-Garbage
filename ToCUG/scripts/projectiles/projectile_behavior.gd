extends RefCounted
class_name ProjectileBehavior

#Parent class for all modifiers to projectile behavior at runtime

func on_attach(_projectile: Projectile) -> void:
	pass

func process(_projectile: Projectile, _delta: float) -> void:
	pass
