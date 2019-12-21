package days;

import haxe.crypto.Md5;

class Day04 {
	public static function mineAdventCoins(input:String, zeroes:Int):Int {
		var i = 0;
		var prefix = "".lpad("0", zeroes);
		while (true) {
			if (Md5.encode(input + i).startsWith(prefix)) {
				return i;
			}
			i++;
		}
	}
}
