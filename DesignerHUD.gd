extends Control

@export var mySelectedResource : PackedScene;
@onready var fire = preload("res://Fireplace.tscn");
@onready var house = preload("res://House.tscn");
@onready var spikes = preload("res://Spikes.tscn");
@onready var enemyTeleporter = preload("res://EnemyTeleporter.tscn");

func _on_exit_editor_button_pressed():
	get_node("/root/World/GameWorld").unpause();
	get_node("/root/World/DesignerWorld").pause();

func _on_clear_editor_button_pressed():
	for i in $"../../SpawnZone".get_children():
		i.queue_free();

func _on_select_fire_button_pressed():
	mySelectedResource = fire;

func _on_select_house_button_pressed():
	mySelectedResource = house;

func _on_select_spikes_button_pressed():
	mySelectedResource = spikes;

func _on_select_enemy_teleporter_button_pressed():
	mySelectedResource = enemyTeleporter;
