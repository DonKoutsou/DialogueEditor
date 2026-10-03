extends PanelContainer


class_name ResourcePicker

@export var resource_Type : FileDialog.FileMode = FileDialog.FileMode.FILE_MODE_OPEN_FILE
@export var resource_Tyoes : PackedStringArray
@export var resource_Class : String
@export var locationText : LineEdit

var selected : String = ""

signal Changed(t : String)

func SetFile(t : String) -> void:
	selected = t
	locationText.text = t

func _on_change_pressed() -> void:
	var fileDiag : FileDialog = FileDialog.new()
	fileDiag.file_mode = resource_Type
	fileDiag.filters = resource_Tyoes
	fileDiag.use_native_dialog = true
	fileDiag.access = FileDialog.ACCESS_FILESYSTEM
	fileDiag.current_path = selected
	add_child(fileDiag)
	fileDiag.popup_centered()
	var f
	if (resource_Type == FileDialog.FileMode.FILE_MODE_OPEN_FILE):
		f = await fileDiag.file_selected
		if (!FileAccess.file_exists(f)):
			return
			
	else: if (resource_Type == FileDialog.FileMode.FILE_MODE_OPEN_DIR):
		f = await fileDiag.dir_selected
		if (!DirAccess.dir_exists_absolute(f)):
			return
	
	if (!resource_Class.is_empty()):
		var loadedFile = load(f)
		if (!is_of_class(loadedFile, resource_Class)):
			print("Wrong File picked, picker expected {0}".format([resource_Class]))
			return
	
	var actualDir = f.replace(DialogueEditor.startingDir, "res:/")
	
	SetFile(actualDir)
	Changed.emit(actualDir)

func is_of_class(file : Object, class_string: String) -> bool:
	var is_instance := false
	if file.get_script():
		if file.get_script().get_global_name() == class_string:
			is_instance = true
	if file.is_class(class_string): # Keep this check in for built-in classes
		is_instance = true
	return is_instance

func _on_line_edit_text_changed(new_text: String) -> void:
	locationText.text = selected
