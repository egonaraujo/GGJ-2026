extends Node2D

signal selected(shard: Node2D)
signal painted(shard: Node2D)

var _is_selected: bool = false
var _color: Color = Color.WHITE
@export_range(0.0, 1.0) var dark_amount: float = 0.5

func _ready() -> void:
	self.unselect()

func select():
	self._is_selected = true
	self.modulate = self._color

func unselect():
	self._is_selected = false
	self.modulate = self._color.darkened(self.dark_amount)

func apply_ink(ink: Color):
	self._color = ink
	self.select()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if self._is_selected:
			self.painted.emit(self)
		else:
			self.selected.emit(self)
