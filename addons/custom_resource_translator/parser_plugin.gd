@tool
class_name CustomResourceTranslationParserPlugin
extends EditorTranslationParserPlugin

func _parse_file(path: String) -> Array[PackedStringArray]:
	var res: Resource = load(path)
	if not res:
		return []
	
	var result: Array[PackedStringArray] = []

	if res is UpgradeDefinition:
		var def: UpgradeDefinition = res as UpgradeDefinition
		result.append(
			PackedStringArray([def.title, def.description])
		)
	
	if res is MissionDefinition:
		var def: MissionDefinition = res as MissionDefinition
		result.append(
			PackedStringArray([def.title])
		)
	
	return result


func _get_recognized_extensions() -> PackedStringArray:
	return ["tres"]
