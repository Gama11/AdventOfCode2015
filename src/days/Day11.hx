package days;

class Day11 {
	static function increment(password:String):String {
		var codes = [for (c in password) c];
		var i = codes.length;
		while (i-- > 0) {
			codes[i]++;
			if (codes[i] > "z".code) {
				codes[i] = "a".code;
			} else {
				break;
			}
		}
		return codes.map(c -> String.fromCharCode(c)).join("");
	}

	public static function isValidPassword(password:String):Bool {
		var maxStraight = 0;
		var straight = 0;
		var pairs = 0;
		var possiblePair = true;
		var prev = 0;
		for (code in password) {
			if (code == "i".code || code == "o".code || code == "l".code) {
				return false;
			}
			if (code == prev + 1) {
				straight++;
			} else {
				maxStraight = Std.int(Math.max(maxStraight, straight));
				straight = 1;
			}
			if (possiblePair && code == prev) {
				pairs++;
				possiblePair = false;
			} else {
				possiblePair = true;
			}
			prev = code;
		}
		return maxStraight >= 3 && pairs >= 2;
	}

	public static function findNextValidPassword(password:String):String {
		do {
			password = increment(password);
		} while (!isValidPassword(password));
		return password;
	}
}
