extends Node3D

var timer = 0.0;
var frequency = 5.0;

func _process(delta):
	timer += delta;
	if timer < frequency:
		return;
	
	timer = 0.0;
	var enemies = [];
	for i in $AffectZone.get_overlapping_bodies():
		if i is Enemy:
			enemies.push_back(i);
	
	if enemies.size() == 0:
		return;
	
	var target = enemies[randi_range(0, enemies.size() - 1)]
	target.global_position = global_position + Vector3(0,5,0);
	target.velocity = Vector3(0,0,0);
	return;
