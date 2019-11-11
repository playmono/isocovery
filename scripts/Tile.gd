extends KinematicBody2D

var _dragging = false;
var _area_overlapping = null;
var _initial_position = Vector2();

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func _physics_process(delta):
	if _dragging == true:
		set_global_position(get_global_mouse_position());


func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if !_dragging && Input.is_action_just_pressed("ui_select"):
		start_dragging();

	if _dragging && Input.is_action_just_released("ui_select"):
		stop_dragging();


func start_dragging():
	# workaround for getting 1 tile at the same time (temporary(
	var tiles = get_tree().get_nodes_in_group("tiles");
	for tile in tiles:
		if get_instance_id() == tile.get_instance_id():
			continue;
		if tile._dragging:
			return;

	set_z_index(2);
	_dragging = true;
	_initial_position = position;


func stop_dragging():
	set_z_index(1);
	_dragging = false;
	
	if set_new_position():
		_area_overlapping = null;
	else:
		position = _initial_position;


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	_area_overlapping = area;


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	_area_overlapping = null;


func set_new_position():
	# are we overlapping some area?
	if _area_overlapping == null:
		return false;

	var new_position = calculate_new_position();
	
	# there is another tile in this position?
	var tiles = get_tree().get_nodes_in_group("tiles");
	for i in tiles:
		if i.position == new_position:
			return false;
	
	position = new_position;
	
	return true;

func calculate_new_position():
	var area_overlapping_position = _area_overlapping.get_global_position();
	var dir_vector =  get_global_position() - area_overlapping_position;
	var final_vector = Vector2(256, 128);

	if dir_vector.x < 0:
		final_vector.x *= -1;

	if dir_vector.y < 0:
		final_vector.y *= -1;

	return area_overlapping_position + final_vector;