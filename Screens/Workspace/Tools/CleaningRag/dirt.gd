extends Node2D

const minAlpha = 0.5
const maxLife :float = 5

var life :float = maxLife

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.name) != "CollisionDetection":
		return
	life -= 1
	self.modulate.a = lerp(minAlpha, 1.0, (life-1)/(maxLife -1))
	print("alpha is ", self.modulate.a)
	if(life <= 0):
		queue_free()
