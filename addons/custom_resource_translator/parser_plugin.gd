@tool
class_name CustomResourceTranslationParserPlugin
extends EditorTranslationParserPlugin

func _parse_file(path: String, msgids: Array[String], msgids_context_plural: Array[Array]) -> void:
	var res: Resource = load(path)
	if not res:
		return

	if res is UpgradeDefinition:
		var def: UpgradeDefinition = res as UpgradeDefinition
		msgids.append(def.title)
		msgids.append(def.description)
	
	if res is MissionDefinition:
		var def: MissionDefinition = res as MissionDefinition
		msgids.append(def.title)


func _get_recognized_extensions() -> PackedStringArray:
	return ["tres"]
