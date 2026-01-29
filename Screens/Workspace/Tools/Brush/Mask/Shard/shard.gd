extends Node2D

signal painted(shard: Node2D)

var _color: Color = Color.WHITE

func _ready() -> void:
	self.apply_ink(self._color)

func apply_ink(ink: Color):
	self._color = ink
	self.modulate = self._color

func _on_area_2d_area_entered(_area: Area2D) -> void:
	self.painted.emit(self)
