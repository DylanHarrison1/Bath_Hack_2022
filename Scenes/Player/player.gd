extends "../Being/being.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var force := 30; # example
export var cam_towards_mouse := 0.25;
export var drag := 0.1;
var canTeleport = true;
onready var timer = get_node("Timer");
onready var cam_pos = $cam_pos;

var velocity := Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Replace with function body.
	pass

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
	if Input.is_action_pressed("fire"):
		$BaseWeapon.fire()
			
	# make diagonals same 'distance' as straights
	dir = dir.normalized();
	if dir != Vector2.ZERO:
		$AnimationPlayer.play("Walk_Down");
	
	var acceleration := dir * force;
	
	velocity += acceleration;
	velocity -= drag * velocity;
	
	move_and_slide(velocity);
	
	_move_camera();
	
	
func _move_camera():
	
	var viewport := get_viewport()
	var mouse_point := viewport.get_mouse_position() - viewport.get_visible_rect().size / 2
	
	rotation = Vector2(1, 0).angle_to(mouse_point)
	
	var cam_dest := global_position + mouse_point * cam_towards_mouse;
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var result = space_state.intersect_ray(global_position, cam_dest)
	
	if result:
		cam_dest = result.position
	
	cam_pos.global_transform = Transform2D(0, cam_dest)



func _unhandled_input(event):
	
	if event.is_action_pressed("ui_accept"):
		damage(10);
		print_debug("Hurt for 10!")
	
	if event.is_action_pressed("teleport") and canTeleport:
		#if Timer.TIMER_PROCESS_IDLE():
		#SceneTreeTimer.CONNECT_ONESHOT()
		#var t = Timer.new()
		#t.set_wait_time(10)
		#add_child(t)
		#get_tree().create_timer(1000)
			global_position = get_global_mouse_position()
			
			timer.set_wait_time(10)
			timer.start()
			canTeleport = false;


func _on_Timer_timeout():
	canTeleport = true;
