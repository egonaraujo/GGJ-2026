extends Node2D

enum ToolType #The collision layer to be used
{
	CLEANING_RAG = 2,
	BRUSH = 4,
	CHISEL = 8,
	ADD_OR_REMOVE = 16,
}

@onready var tool_effect  = {
	ToolType.CLEANING_RAG: $CollisionDetection/Rag
	, ToolType.BRUSH: $CollisionDetection/Brush
}

@onready var collisionDetection : Area2D = $CollisionDetection
const hiddenPos := Vector2(-100,-100)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch):
		if(event.is_pressed()):
			collisionDetection.position = event.position
		if(event.is_released()):
			collisionDetection.position = hiddenPos
	if ( event is InputEventScreenDrag):
			collisionDetection.position = event.position

func selectTool(event: InputEvent, tool: ToolType) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		self.collisionDetection.collision_layer = tool
		self.collisionDetection.collision_mask = tool

		for key in self.tool_effect:
			self.tool_effect[key].visible = false

		self.tool_effect[tool].visible = true


func _on_tool_rag_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	self.selectTool(event, ToolType.CLEANING_RAG)

func _on_tool_brush_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	self.selectTool(event, ToolType.BRUSH)

