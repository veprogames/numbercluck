class_name F
extends Object


static func t(num: float) -> String:
	if num == 0:
		return "0"
	if num < 0:
		return "-%s" % F.t(-num)
	if num < 1_000:
		return "%d" % num
	
	var reversed: String = str(int(num)).reverse()
	var result: String = ""
	
	for i: int in len(reversed):
		var char_: String = reversed[i]
		if i % 3 == 0 and i > 0:
			result += "." if TranslationServer.get_locale() == "de_DE" else ","
		result += char_
	
	return result.reverse()
