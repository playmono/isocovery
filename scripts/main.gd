extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var tileScene = preload("res://scenes/tile.tscn");
	var sceneObj = tileScene.instance();
	var ySortNode = get_node("YSort");

	ySortNode.add_child(sceneObj);
	
	sceneObj.position.x = 250;
	sceneObj.position.y = 250;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass