extends Node2D

signal painted(shard: Node2D)

var _color: Color = Color.WHITE

func apply_ink(ink: Color):
	self._color = ink
	self.modulate = self._color

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.name) != "CollisionDetection":
		return
	self.painted.emit(self)
