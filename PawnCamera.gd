extends Camera3D

@onready var spawnzone = get_node("/root/World/GameWorld/SpawnZone");
var myCamInput = Vector2(0.0, 0.0);
var myMouseMode = Input.MOUSE_MODE_VISIBLE;
var myMouseSensitivity = 2;
var myHasClicked = false;
var myActiveEntity = null;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	return;

func _process(delta):
		#show mouse when pressing escape.
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
	
	if !myHasClicked && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && $RayCast3D.is_colliding():
		if myActiveEntity:
			myActiveEntity.queue_free();
		myActiveEntity = get_node("/root/World/DesignerWorld/SpawnZone").duplicate();
		myActiveEntity.name = "myActiveEntity";
		myActiveEntity.position = $RayCast3D.get_collision_point();
		var forward = Vector3(transform.basis.z.x, 0, transform.basis.z.z).normalized();
		myActiveEntity.transform.basis = Basis.looking_at(forward);
		spawnzone.add_child(myActiveEntity, true);
		myHasClicked = true;
	
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		myHasClicked = false;
	
	return;

func _input(event):
	#is is actually is of type.
	if event is InputEventMouseMotion:
		myCamInput += event.relative;
	return;
