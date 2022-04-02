extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var bullet_speed := 1000
export var shake_factor := 5.0;
export var aim_factor := 0.1;


var bullet = preload("res://Scenes//Bullet//Bullet.tscn")
var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func fire():
	var bullet_instance = bullet.instance()
	
	var random_offset := Vector2(1, 0).rotated(global_rotation + PI / 2) * rng.randf_range(-1, 1) * shake_factor
	var random_angle := rng.randf_range(-1, 1) * aim_factor
	
	bullet_instance.global_position = $bullet_spawn.global_position + random_offset
	bullet_instance.global_rotation = global_rotation + random_angle
	$bulletcontainer.add_child(bullet_instance)
