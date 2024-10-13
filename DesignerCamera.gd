extends Camera3D
@onready var myFireplacePrefab = preload("res://Fireplace.tscn");
@onready var mySpawnZone = $"../SpawnZone";

var myCamInput = Vector2(0.0, 0.0);
var myMouseMode = Input.MOUSE_MODE_VISIBLE;
var myMouseSensitivity = 2;
var myHasClicked = false;

const BASE_SPEED = 0.05;
const RUN_SPEED = 0.5;

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
	
	if myMouseMode != Input.MOUSE_MODE_CAPTURED:
		myHasClicked = true;
	
	if myMouseMode == Input.MOUSE_MODE_CAPTURED && !myHasClicked && $SpawnCast.is_colliding():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var spawnedEntity = myFireplacePrefab.instantiate();
			mySpawnZone.add_child(spawnedEntity, true);
			spawnedEntity.position = $SpawnCast.get_collision_point();
			myHasClicked = true;
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		myHasClicked = false;
	
	if(Input.is_key_pressed(KEY_ESCAPE)):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		myMouseMode = Input.MOUSE_MODE_VISIBLE;
	
	#when mouse is visible.
	if(myMouseMode == Input.MOUSE_MODE_VISIBLE):
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
			myMouseMode = Input.MOUSE_MODE_CAPTURED;
	
	#when mouse is captured.
	if(myMouseMode == Input.MOUSE_MODE_CAPTURED):
		var rot = Vector3(0.0,0.0,0.0);
		rot.x = clamp(rotation.x - myCamInput.y / 10 * myMouseSensitivity * delta, -0.5 * PI, 0.5 * PI);
		rot.y = rotation.y - myCamInput.x / 10 * myMouseSensitivity * delta;
		rot.z = rotation.z;
		set_rotation(rot);
		myCamInput = Vector2(myCamInput.x / 10, myCamInput.y / 10);
	
	return;

func _input(event):
	#is is actually is of type.
	if event is InputEventMouseMotion:
		myCamInput += event.relative;
	return;
