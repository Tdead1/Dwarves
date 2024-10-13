extends Control

func _on_enter_editor_button_pressed():
	get_node("/root/World/DesignerWorld").unpause();
	get_node("/root/World/GameWorld").pause();
