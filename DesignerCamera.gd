extends Camera3D

@onready var mySpawnZone = $"../SpawnZone";
@onready var myDesignerWorld = $"..";
@onready var myPreviewMaterialOverride = preload("res://PreviewMaterialOverride.tres");

var myCamInput = Vector2(0.0, 0.0);
var myMouseMode = Input.MOUSE_MODE_VISIBLE;
var myMouseSensitivity = 2;
var myHasClicked = false;
var myPreviewBuild = true; 
var myActivePreviewEntity = null;

const BASE_SPEED = 0.05;
const RUN_SPEED = 0.5;

func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	return;

func _process(delta):
	#show mouse when pressing escape.
	var input_up = float(Input.is_action_pressed("ui_accept"));
	var input_down = - float(Input.is_key_pressed(KEY_CTRL));
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward");
	var input_run = Input.get_action_strength("Run");
	var speed = BASE_SPEED + RUN_SPEED * input_run;
	var direction = (transform.basis * Vector3(input_dir.x, input_up + input_down, input_dir.y)).normalized();
	position += direction * speed;
	
	if myActivePreviewEntity:
		myActivePreviewEntity.queue_free();
	if myPreviewBuild:
		myActivePreviewEntity = $UIWorldHUD.mySelectedResource.instantiate();
		myActivePreviewEntity.name = "myActivePreviewEntity";
		myActivePreviewEntity.position = $SpawnCast.get_collision_point();
		myDesignerWorld.add_child(myActivePreviewEntity, true);
		var forward = Vector3(transform.basis.z.x, 0, transform.basis.z.z).normalized();
		myActivePreviewEntity.transform.basis = Basis.looking_at(forward);
		var previewChildrenNodes = [];
		get_all_children(myActivePreviewEntity,previewChildrenNodes);
		for i in previewChildrenNodes:
			if i is MeshInstance3D:
				i.material_override = myPreviewMaterialOverride;
	
	if Input.is_action_just_pressed("ui_home"):
		myPreviewBuild = !myPreviewBuild;
	
	if myMouseMode != Input.MOUSE_MODE_CAPTURED:
		myHasClicked = true;
	
	if myMouseMode == Input.MOUSE_MODE_CAPTURED && !myHasClicked && $SpawnCast.is_colliding():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var spawnedEntity = $UIWorldHUD.mySelectedResource.instantiate();
			mySpawnZone.add_child(spawnedEntity, true);
			spawnedEntity.position = $SpawnCast.get_collision_point();
			var forward = Vector3(transform.basis.z.x, 0, transform.basis.z.z).normalized();
			spawnedEntity.transform.basis = Basis.looking_at(forward);
			myHasClicked = true;
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		myHasClicked = false;
	
	if(Input.is_key_pressed(KEY_ESCAPE)):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		myMouseMode = Input.MOUSE_MODE_VISIBLE;
	
	#when mouse is captured.
	if(myMouseMode == Input.MOUSE_MODE_CAPTURED):
		var rot = Vector3(0.0,0.0,0.0);
		rot.x = clamp(rotation.x - myCamInput.y / 10 * myMouseSensitivity * delta, -0.5 * PI, 0.5 * PI);
		rot.y = rotation.y - myCamInput.x / 10 * myMouseSensitivity * delta;
		rot.z = rotation.z;
		set_rotation(rot);
		myCamInput = Vector2(myCamInput.x / 10, myCamInput.y / 10);
	
	#when mouse is visible.
	if(myMouseMode == Input.MOUSE_MODE_VISIBLE):
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
			myMouseMode = Input.MOUSE_MODE_CAPTURED;
	return;

func _input(event):
	#is is actually is of type.
	if event is InputEventMouseMotion:
		myCamInput += event.relative;
	return;
