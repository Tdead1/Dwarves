extends Node3D

@onready var spawnparticles = preload("res://SpawnParticles.tscn");

func _ready():
	for i in get_children():
		var putOnGroundCast = RayCast3D.new();
		spawnparticles.instantiate()
		i.add_child(putOnGroundCast);
		i.add_child(spawnparticles.instantiate());
		putOnGroundCast.target_position = Vector3(0, -600, 0);
		putOnGroundCast.position = Vector3(0,300,0);
		putOnGroundCast.force_raycast_update();
		if !putOnGroundCast.is_colliding():
			i.queue_free();
			continue;
		i.position.y = putOnGroundCast.get_collision_point().y - position.y;
		i.remove_child(putOnGroundCast);
		putOnGroundCast.queue_free();
