class_name F
extends Object


static var suffixes: Array[String] = [
	"",
	TranslationServer.tr("Bil."),
	TranslationServer.tr("Quint."),
	TranslationServer.tr("Oct.")
]


static func n(num: float, places: int = 0) -> String:
	if num == 0:
		return ("%%.%df" % places) % num
	if num < 0:
		return "-%s" % F.n(-num, places)
	
	var log10: int = int(log(num) / log(10))
	@warning_ignore("integer_division")
	var index: int = (log10 - 2) / 9
	index = clampi(index, 0, len(suffixes) - 1)
	
	var mantissa: String = F.t(num / 10.0 ** (9 * index), places)
	var suffix: String = suffixes[index]
	
	if len(suffix) == 0:
		return mantissa
	
	return "%s %s" % [mantissa, suffix]


static func t(num: float, places: int = 0) -> String:
	if num < 0:
		return "-%s" % F.t(-num, places)
	
	var format_string: String = ("%%.%df" % places) % num
	var end: int = format_string.find(".")
	if end == -1:
		end = len(format_string)
	
	var result: String = ""
	
	for i: int in len(format_string):
		result += format_string[i]
		
		if i > end:
			continue
		
		var digit: int = end - i
		if digit % 3 == 1 and digit > 1:
			result += "." if TranslationServer.get_locale() == "de_DE" else ","
	
	return result
