package days;

class Day25 {
	public static function findCode(targetRow:Int, targetColumn:Int):Int {
		var row = 1;
		var column = 1;
		var diagonal = 1;
		var code = 20151125;
		while (true) {
			row--;
			column++;
			if (row == 0) {
				diagonal++;
				row = diagonal;
				column = 1;
			}
			code = (code * 252533) % 33554393;
			if (row == targetRow && column == targetColumn) {
				return code;
			}
		}
	}
}
