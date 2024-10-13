class_name Enemy;
extends CharacterBody3D

@onready var myPlayer = get_node("/root/World/GameWorld/PlayerPawn");
var mySpeed = 200; 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity");

func _process(delta):
	if !is_on_floor():
		set_velocity(Vector3(0.0, -gravity, 0.0));
	else:
		var toPlayer = myPlayer.position - position;
		var velocityTarget = toPlayer.normalized() * mySpeed * delta;
		set_velocity(velocityTarget);
	move_and_slide();
