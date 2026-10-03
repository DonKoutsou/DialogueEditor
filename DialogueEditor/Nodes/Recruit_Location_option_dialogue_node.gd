@tool
extends BaseDialogueNode

class_name RecruitLocatorOptionDialogueNode

@export var resourceLoc : ResourcePicker
@export var spinB : SpinBox

var option : Recruit_Locator_Happening_Option

func ConfigureOption(options : Recruit_Locator_Happening_Option) -> void:
	resourceLoc.SetFile(options.resource_path)
	option = options
	spinB.set_value_no_signal(options.locatorRange)

func _on_spin_box_value_changed(value: float) -> void:
	option.locatorRange = value


func _on_option_picker_changed(t: String) -> void:
	ConfigureOption(load(t))
