extends Node3D

@onready var enemy = preload("res://Enemy.tscn");

func pause():
	process_mode = PROCESS_MODE_DISABLED
	get_node("PlayerPawn/Camera/GameHud").visible = false;
	visible = false;

func unpause():
	process_mode = PROCESS_MODE_INHERIT
	get_node("PlayerPawn/Camera/GameHud").visible = true;
	visible = true;
	get_node("PlayerPawn/Camera").current = true;

func _process(delta):
	if Input.is_action_just_pressed("ui_text_submit"):
		var instance = enemy.instantiate();
		add_child(instance, true);
		instance.global_position = Vector3(randf_range(-50.0, 0.0), 2.0, randf_range(-50.0, 50.0));
