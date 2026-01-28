extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event):
	if (event is InputEventScreenTouch):
		if(event.is_pressed()):
			var point = event.position
			var space_state = get_world_2d().direct_space_state
			var query = PhysicsShapeQueryParameters2D.new()
			query.transform = Transform2D(0, point)
			query.collide_with_bodies = false
			query.collide_with_areas = true
			var circle = CircleShape2D.new()
			circle.radius = 2
			query.shape = circle
			var collidersTouched = space_state.intersect_shape(query)
			for dict in collidersTouched:
				if (dict.collider == $Dirts/Dirt/Area2D ):
					$Dirts/Dirt.queue_free()
				if (dict.collider == $Dirts/Dirt2/Area2D ):
					$Dirts/Dirt2.queue_free()
				if (dict.collider == $Dirts/Dirt3/Area2D ):
					$Dirts/Dirt3.queue_free()

	if( event is InputEventScreenDrag):
		var point = event.position
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsShapeQueryParameters2D.new()
		query.transform = Transform2D(0, point)
		query.collide_with_bodies = false
		query.collide_with_areas = true
		var circle = CircleShape2D.new()
		circle.radius = 2
		query.shape = circle
		var collidersTouched = space_state.intersect_shape(query)
		for dict in collidersTouched:
			if (dict.collider == $Dirts/Dirt/Area2D ):
				$Dirts/Dirt.queue_free()
			if (dict.collider == $Dirts/Dirt2/Area2D ):
				$Dirts/Dirt2.queue_free()
			if (dict.collider == $Dirts/Dirt3/Area2D ):
				$Dirts/Dirt3.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
