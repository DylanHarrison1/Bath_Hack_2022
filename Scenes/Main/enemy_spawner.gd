extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var enemy_num = 5;
export (NodePath) var player_path;
onready var player = get_node(player_path)

var enemy := preload("../Enemies/Gobster.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in enemy_num:
		var enemy_inst = enemy.instance()
		enemy_inst.player = player
		enemy_inst.position += Vector2.ONE * (randi() % 1000) / 1000
		add_child(enemy_inst)


