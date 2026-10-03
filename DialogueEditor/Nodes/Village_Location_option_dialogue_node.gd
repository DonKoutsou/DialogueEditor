@tool
extends BaseDialogueNode

class_name VillageLocatorOptionDialogueNode

@export var resourceLoc : ResourcePicker
@export var spinB : SpinBox

var option : Village_Locator_Happening_Option

func ConfigureOption(options : Village_Locator_Happening_Option) -> void:
	resourceLoc.SetFile(options.resource_path)
	option = options
	spinB.set_value_no_signal(options.locatorRange)
	
func _on_spin_box_value_changed(value: float) -> void:
	option.locatorRange = value

func _on_option_changed(t: String) -> void:
	ConfigureOption(load(t))
