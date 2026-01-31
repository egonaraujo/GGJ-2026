extends Node2D

signal selected(shard: Node2D)

@onready var _border: Node2D = $Border
@onready var _ink_sprite: Node2D = $Sprite2D

@export var ink: Color

func _ready() -> void:
	self._ink_sprite.modulate = ink
	self.unselect()

func select():
	self._border.visible = true

func unselect():
	self._border.visible = false

func set_ink_color(color: Color) -> void:
	ink = color

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		self.selected.emit(self)
