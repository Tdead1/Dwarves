extends Node3D
func _ready():
	pause();

func pause():
	process_mode = PROCESS_MODE_DISABLED
	visible = false;
	get_node("DesignerCamera/UIWorldHUD").visible = false;

func unpause():
	process_mode = PROCESS_MODE_INHERIT
	visible = true;
	get_node("DesignerCamera/UIWorldHUD").visible = true;
	get_node("DesignerCamera").current = true;
