extends Node
class_name ProjectileModifier
# The super class of all modifiers of projectiles

@export var modifier_name: String = "Modifier"

func apply(context: FireContext) -> void:
	context.register_projectile_modifers(self)

func on_projectile_spawned(projectile: Projectile) -> void:
	pass
