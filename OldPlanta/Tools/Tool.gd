extends Node2D

@export var toolID: int = -1;
@export var tool_asset: NodePath

signal tool_selected

func _process(delta):
	$highlight.set_rotation($highlight.get_rotation() + delta)

func _input(event):
	if (self.visible == false):
		return
	if (event is InputEventScreenTouch):
		if(event.is_pressed()):
			var point = event.position
			var space_state = get_world_2d().direct_space_state
			var query = PhysicsPointQueryParameters2D.new()
			query.position = point
			query.collide_with_areas = true
			query.collide_with_bodies = false
			var collidersTouched = space_state.intersect_point(query)
			var touchItem = false
			for dict in collidersTouched:
				if (dict.collider == $Area2D):
					touchItem = true
					break
			if(touchItem):
				emit_signal("tool_selected",toolID)

func select():
	$highlight.show()

func deselect():
	$highlight.hide()

func required(isRequired:bool):
	outline(isRequired)

func outline(show:bool):
	get_node(tool_asset).material.set_shader_parameter("enabled", true if show  else false)
