tool
extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var size := Vector2.ONE * 50;

# Called when the node enters the scene tree for the first time.
func _ready():
	for y in range(- size.y / 2, size.y):
		for x in range(- size.x / 2, size.x):
			if get_cell(x, y) == INVALID_CELL:
				set_cell(x, y, 1);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
