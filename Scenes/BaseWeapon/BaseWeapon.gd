extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var bullet_speed = 1000
var bullet = preload("res://Scenes//Bullet//Bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed ,0).rotated(rotation))
	$bulletcontainer.add_child(bullet_instance)
