extends Node


onready var player = $Player;
onready var nav = $Level;

func _on_Timer_timeout():
	get_tree().call_group("Enemy","get_target_path",player.global_position)
