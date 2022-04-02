extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_health = 100;

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health


func damage(damage):
	health -= damage
	if health < 0:
		_die()

func _die():
	queue_free()
