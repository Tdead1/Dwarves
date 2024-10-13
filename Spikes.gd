extends Node3D
class_name Spikes;

func _process(delta):
	for i in $StaticBody3D.get_overlapping_bodies():
		if i is Enemy:
			i.queue_free();
