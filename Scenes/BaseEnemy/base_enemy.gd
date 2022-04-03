extends "../Being/being.gd"

var player


export var damage = 10;


func _ready():
	pass
	
# warning-ignore:unused_argument
func _physics_process(delta):
	
	var force = player.global_position - global_position
	force = force.normalized()
	
	rotation = Vector2(1, 0).angle_to(force)
	
	apply_force(force)
	
	




func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		print("hurt")
		body.damage(damage)
