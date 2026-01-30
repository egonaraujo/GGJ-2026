extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	#emit unified signal about completion of tasks?
	queue_free()
