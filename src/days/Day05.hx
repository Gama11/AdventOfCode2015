package days;

class Day05 {
	static final letters = [for (i in "a".code..."z".code + 1) String.fromCharCode(i)];
	static final letterCombinations = [for (a in letters) for (b in letters) a + b];

	public static function isNiceString(s:String):Bool {
		if (~/(ab|cd|pq|xy)/.match(s)) {
			return false;
		}
		var vowels = ~/[aeiou]/g.split(s).length - 1;
		return vowels >= 3 && letters.exists(l -> s.contains(l + l));
	}

	public static function isNiceString2(s:String):Bool {
		if (!letterCombinations.exists(c -> s.split(c).length - 1 >= 2)) {
			return false;
		}
		return letters.exists(l -> new EReg('$l.$l', "").match(s));
	}

	public static function countNiceStrings(input:String, rule:String->Bool):Int {
		return input.split("\n").filter(rule).length;
	}
}
