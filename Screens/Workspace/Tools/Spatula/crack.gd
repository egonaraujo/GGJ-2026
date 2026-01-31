extends Node2D

const maxLife = 5

var life = maxLife

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.name) != "CollisionDetection":
		return
	life -= 1
	if(life <= 0):
		queue_free()
	($Asset as Sprite2D).frame = life - 1
