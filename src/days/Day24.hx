package days;

class Day24 {
	public static function findIdealQuantumEntanglement(input:String):Int {
		var packages = input.split("\n").map(Std.parseInt);
		packages.reverse();
		var groupCapacity = Std.int(packages.sum() / 3);
		var firstGroup = [];
		for (weight in packages) {
			var sum = firstGroup.sum();
			if (sum + weight <= groupCapacity) {
				firstGroup.push(weight);
			}
		}
		return firstGroup.product();
	}
}
