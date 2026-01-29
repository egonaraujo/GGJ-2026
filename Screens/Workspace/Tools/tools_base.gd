extends Node2D
class_name ToolsBase

enum ToolType
{
	BRUSH,
	CLEANING_RAG,
	CHISEL,
	ADD_OR_REMOVE,
}

@export var button : Area2D
@export var collisionDetection : Area2D
@export var toolType : ToolType

var isSelected := false
const hiddenPos := Vector2(10000,10000)

func _ready() -> void:
	collisionDetection.position = hiddenPos
	button.input_event.connect(selectTool)

# Basic definitions, to be implemented by child classes
func selectTool(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			toolSelected()
	pass

func toolSelected() -> void:
	isSelected = true


func _input(event: InputEvent) -> void:
	if (!isSelected):
		return
	if (event is InputEventScreenTouch):
		if(event.is_pressed()):
			collisionDetection.position = event.position
		if(event.is_released()):
			collisionDetection.position = hiddenPos
	if ( event is InputEventScreenDrag):
			collisionDetection.position = event.position
	
