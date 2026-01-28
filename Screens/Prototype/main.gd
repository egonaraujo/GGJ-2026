extends Node2D

var _shards: Array[Node]
var _inks: Array[Node]

var _chosen_ink: Color;

func _ready() -> void:
	self._shards = $Mask.shards()
	for shard in self._shards:
		shard.selected.connect(_on_shard_selected)
		shard.painted.connect(_on_shard_painted)

	self._inks = $ColorPicker.inks()
	for ink in self._inks:
		ink.selected.connect(_on_ink_selected)

	self._on_ink_selected(self._inks[0])

func _on_ink_selected(chosen: Node2D):
	for ink in self._inks:
		ink.unselect()
	chosen.select()
	self._chosen_ink = chosen.ink

func _on_shard_selected(chosen: Node2D):
	for shard in self._shards:
		shard.unselect()
	chosen.select()

func _on_shard_painted(shard: Node2D):
	shard.apply_ink(self._chosen_ink);
