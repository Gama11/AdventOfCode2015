package days;

class Day01 {
	public static function walk(input:String) {
		var floor = 0;
		var basementCharacter = null;
		for (i in 0...input.length) {
			floor += switch input.charAt(i) {
				case "(": 1;
				case ")": -1;
				case _: throw "invalid char";
			}
			if (basementCharacter == null && floor == -1) {
				basementCharacter = i + 1;
			}
		}
		return {
			finalFloor: floor,
			basementCharacter: basementCharacter
		};
	}
}
