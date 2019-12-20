package days;

class Day02 {
	public static function calculateWrappingPaperRequirement(input:String):Int {
		return input.split("\n").map(function(line) {
			var sides = line.split("x").map(Std.parseInt);
			var l = sides[0];
			var w = sides[1];
			var h = sides[2];
			var sideAreas = [l * w, w * h, h * l];
			return sideAreas.sum() * 2 + sideAreas.min(i -> i).value;
		}).sum();
	}

	public static function calculateRibbonRequirement(input:String):Int {
		return input.split("\n").map(function(line) {
			var sides = line.split("x").map(Std.parseInt);
			var l = sides[0];
			var w = sides[1];
			var h = sides[2];
			sides.sort(Reflect.compare);
			return (l * w * h) + (sides[0] + sides[1]) * 2;
		}).sum();
	}
}
