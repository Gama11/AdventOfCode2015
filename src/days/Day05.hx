package days;

class Day05 {
	public static function isNiceString(s:String):Bool {
		if (~/(ab|cd|pq|xy)/.match(s)) {
			return false;
		}
		var vowels = ~/[aeiou]/g.split(s).length - 1;
		var letters = [for (i in "a".code..."z".code + 1) String.fromCharCode(i)];
		return vowels >= 3 && letters.exists(l -> s.contains(l + l));
	}

	public static function countNiceStrings(input:String):Int {
		return input.split("\n").filter(isNiceString).length;
	}
}
