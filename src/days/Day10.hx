package days;

class Day10 {
	public static function lookAndSay(input:String, rounds:Int = 1) {
		if (rounds == 0) {
			return input;
		}
		var result = "";
		var run = 0;
		var prev = null;
		for (i in 0...input.length + 1) {
			var c = input.charAt(i);
			if (c != prev) {
				if (prev != null) {
					result += run;
					result += prev;
				}
				run = 0;
			}
			run++;
			prev = c;
		}
		return lookAndSay(result, rounds - 1);
	}
}
