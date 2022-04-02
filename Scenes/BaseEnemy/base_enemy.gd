extends "../Being/being.gd"

var player

func _ready():
	pass
	
# warning-ignore:unused_argument
func _physics_process(delta):
	
	var force = player.global_position - global_position
	force = force.normalized()
	
	apply_force(force)

