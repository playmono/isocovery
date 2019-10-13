extends KinematicBody2D

var object_dragged = false;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func _physics_process(delta):
	if object_dragged == true:
		set_global_position(get_global_mouse_position());

func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	var tiles = get_tree().get_nodes_in_group("tiles");
	for tile in tiles:
		if get_instance_id() == tile.get_instance_id():
			continue;
		if tile.object_dragged:
			return;
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		set_z_index(5);
		object_dragged = true;
	else:
		set_z_index(0);
		object_dragged = false;
