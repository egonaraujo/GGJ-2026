extends Node2D

enum ToolType #The collision layer to be used
{
	CLEANING_RAG = 2,
	BRUSH = 4,
	CHISEL = 8,
	SPATULA = 16,
	NONE = 512
}

@onready var tool_effect  = {
	ToolType.CLEANING_RAG: $CollisionDetection/Rag
	, ToolType.BRUSH: $CollisionDetection/Brush
	, ToolType.CHISEL: $CollisionDetection/Chisel
	, ToolType.SPATULA: $CollisionDetection/Spatula
}

@onready var tool_actions = {
	ToolType.CLEANING_RAG: $Dirts
	, ToolType.BRUSH: $BrushArea/PaintingCanvas
	, ToolType.CHISEL: $Rocks
	, ToolType.SPATULA: $Cracks
}

@onready var tool_buttons = {
	ToolType.CLEANING_RAG: $ToolSelection/ToolRag
	, ToolType.BRUSH: $ToolSelection/ToolBrush
	, ToolType.CHISEL: $ToolSelection/ToolChisel
	, ToolType.SPATULA: $ToolSelection/ToolSpatula
}

@onready var collisionDetection : Area2D = $CollisionDetection
const hiddenPos := Vector2(-100,-100)
var selectedTool := ToolType.NONE

const toolX = 12
const hideTool = -60
const toolSpeed = 5 
var moveHorizontally := []

func _process(delta: float) -> void:
	var toRemove = []
	for tuple in moveHorizontally:
		var tool :ToolType = tuple[0]
		var targetX : int = tuple[1]
		if (tool == ToolType.NONE):
			toRemove.append(tuple)
			continue
		
		var direction = targetX - tool_buttons[tool].position.x
		tool_buttons[tool].position.x += direction * toolSpeed * delta
		
		# use 1 extra distance for safety
		if (tool_buttons[tool].position.x > toolX-1):
			tool_buttons[tool].position.x = toolX
			toRemove.append(tuple)
		if (tool_buttons[tool].position.x < hideTool+1):
			tool_buttons[tool].position.x = hideTool
			toRemove.append(tuple)
	
	for tuple in toRemove:
		moveHorizontally.erase(tuple)

func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch):
		if(event.is_pressed()):
			collisionDetection.position = event.position
		if(event.is_released()):
			collisionDetection.position = hiddenPos
	if ( event is InputEventScreenDrag):
			collisionDetection.position = event.position

func selectTool(event: InputEvent, tool: ToolType) -> void:
	if (selectedTool == tool):
		return
	if event is InputEventMouseButton and event.is_pressed():
		self.collisionDetection.collision_layer = tool
		self.collisionDetection.collision_mask = tool

		# remove old movement
		moveHorizontally.erase([selectedTool, hideTool])
		moveHorizontally.erase([tool, toolX])
		
		# add new movement
		moveHorizontally.append([selectedTool, toolX])
		moveHorizontally.append([tool, hideTool])
		
		var isBrush = tool == ToolType.BRUSH
		tool_actions[ToolType.BRUSH].change_ink_visibility(isBrush)

		if (selectedTool != ToolType.NONE):
			self.tool_effect[selectedTool].visible = false
		self.tool_effect[tool].visible = true
		selectedTool = tool


func _on_tool_rag_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	self.selectTool(event, ToolType.CLEANING_RAG)

func _on_tool_brush_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	self.selectTool(event, ToolType.BRUSH)

func _on_tool_chisel_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	self.selectTool(event, ToolType.CHISEL)

func _on_tool_spatula_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	self.selectTool(event, ToolType.SPATULA)
