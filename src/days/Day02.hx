package days;

class Day02 {
	public static function calculateWrappingPaperRequirement(input:String):Int {
		return input.split("\n").map(function(line) {
			var s = line.split("x").map(Std.parseInt);
			var l = s[0];
			var w = s[1];
			var h = s[2];
			var sideAreas = [l * w, w * h, h * l];
			return sideAreas.sum() * 2 + sideAreas.min(i -> i).value;
		}).sum();
	}
}
