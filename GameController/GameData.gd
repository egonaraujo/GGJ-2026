class_name GameData

const Identifier : String = "PSC"
const DataVersion : int = 1
var HighScore   : int
var Level1Score : int
var Level2Score : int
var Level3Score : int
var Level4Score : int
var Level5Score : int

func _init() -> void:
	reset()

func reset() -> void:
	HighScore = 0
	Level1Score = 0
	Level2Score = 0
	Level3Score = 0
	Level4Score = 0
	Level5Score = 0

func read_from_file(path:String) -> void:
	if not FileAccess.file_exists(path):
		return # Error! We don't have a save to load.
	var file = FileAccess.open(path, FileAccess.READ)
	var file_identifier = file.get_buffer(24).get_string_from_ascii()
	if (Identifier != file_identifier):
		print("Error reading the save file:  ", path)
		file.close()
		return
	var data_version = file.get_32()
	HighScore = file.get_32()
	Level1Score = file.get_32()
	Level2Score = file.get_32()
	Level3Score = file.get_32()
	Level4Score = file.get_32()
	Level5Score = file.get_32()
	file.close()
	
func write_to_file(path:String) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_buffer(Identifier.to_ascii_buffer())
	file.store_32(DataVersion)
	file.store_32(HighScore)
	file.store_32(Level1Score)
	file.store_32(Level2Score)
	file.store_32(Level3Score)
	file.store_32(Level4Score)
	file.store_32(Level5Score)
	file.close()

func debug() -> void:
	print("Identifier: ", Identifier)
	print("DataVersion: ", DataVersion)
	print("HighScore: ", HighScore)
	print("Level1Score: ", Level1Score)
	print("Level2Score: ", Level2Score)
	print("Level3Score: ", Level3Score)
	print("Level4Score: ", Level4Score)
	print("Level5Score: ", Level5Score)
