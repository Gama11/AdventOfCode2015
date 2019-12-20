package days;

class Day01 {
	public static function countFloor(input:String):Int {
		var floor = 0;
		for (i in 0...input.length) {
			floor += switch input.charAt(i) {
				case "(": 1;
				case ")": -1;
				case _: throw "invalid char";
			}
		}
		return floor;
	}
}
