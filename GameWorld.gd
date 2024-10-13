extends Node3D

func pause():
	process_mode = PROCESS_MODE_DISABLED
	get_node("PlayerPawn/Camera/GameHud").visible = false;
	visible = false;

func unpause():
	process_mode = PROCESS_MODE_INHERIT
	get_node("PlayerPawn/Camera/GameHud").visible = true;
	visible = true;
	get_node("PlayerPawn/Camera").current = true;
