extends KinematicBody2D

var dragging = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func _physics_process(delta):
	if dragging == true:
		set_global_position(get_global_mouse_position());

func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("ui_select"):
		start_dragging();

	if Input.is_action_just_released("ui_select"):
		stop_dragging();
		
func start_dragging():
	# workaround for getting 1 tile at the same time (temporary(
	var tiles = get_tree().get_nodes_in_group("tiles");
	for tile in tiles:
		if get_instance_id() == tile.get_instance_id():
			continue;
		if tile.dragging:
			return;

	set_z_index(2);
	dragging = true;
	
func stop_dragging():
	set_z_index(1);
	dragging = false;
