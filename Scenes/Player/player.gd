extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 250; # example
export var cam_towards_mouse := 0.25;
export var drag := 0.1;

onready var cam_pos = $cam_pos;

var velocity := Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# handle movement here
func _physics_process(delta):
	
	var dir := Vector2.ZERO;
	
	# handle movement cases
	if Input.is_action_pressed("move_up"):
		dir += Vector2(0, -1);	
	if Input.is_action_pressed("move_down"):
		dir += Vector2(0, 1);
	if Input.is_action_pressed("move_left"):
		dir += Vector2(-1, 0);
	if Input.is_action_pressed("move_right"):
		dir += Vector2(1, 0);
			
	# make diagonals same 'distance' as straights
	dir = dir.normalized();
	
	#var acceleration := dir * 
	
	move_and_slide(dir * speed);
	
	_move_camera();
	
	
func _move_camera():
	
	var viewport = get_viewport()
	var mouse_point = viewport.get_mouse_position() - viewport.get_visible_rect().size / 2
	
	cam_pos.transform = Transform2D(0, mouse_point * cam_towards_mouse);
	
	
