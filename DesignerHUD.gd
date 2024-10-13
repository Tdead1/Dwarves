extends Control

#^"/root" # Equivalent to get_tree().get_root().
#^"/root/Main" # If your main scene's root node were named "Main".

func _on_exit_editor_button_pressed():
	get_node("/root/World/GameWorld").unpause();
	get_node("/root/World/DesignerWorld").pause();


func _on_clear_editor_button_pressed():
	for i in $"../../SpawnZone".get_children():
		i.queue_free();
