package days;

class Day12 {
	public static function sumNumbers(input:String):Int {
		var numbers = [];
		~/-?\d+/g.map(input, function(e) {
			numbers.push(e.int(0));
			return "";
		});
		return numbers.sum();
	}
}
