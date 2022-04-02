extends "../Being/being.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var cam_towards_mouse := 0.25;
onready var cam_pos = $cam_pos;

export(NodePath) var gun_path
onready var gun := get_node(gun_path)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# handle movement here
func _physics_process(delta):
	var force := Vector2.ZERO;
	
	# handle movement cases
	if Input.is_action_pressed("move_up"):
		force += Vector2(0, -1);	
	if Input.is_action_pressed("move_down"):
		force += Vector2(0, 1);
	if Input.is_action_pressed("move_left"):
		force += Vector2(-1, 0);
	if Input.is_action_pressed("move_right"):
		force += Vector2(1, 0);
	
	force = force.normalized();
	apply_force(force)
	
	if Input.is_action_pressed("fire"):
		if gun:
			gun.try_fire()
			
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
	
	if event.is_action_pressed("teleport"):
		global_position = get_global_mouse_position()
