package days;

class Day24 {
	public static function findIdealQuantumEntanglement(input:String, groups:Int):Int {
		var packages = input.split("\n").map(Std.parseInt);
		packages.reverse();
		var groupCapacity = Std.int(packages.sum() / groups);
		var firstGroupOptions = packages.map(function(startingWeight) {
			var group = [startingWeight];
			for (weight in packages) {
				if (weight == startingWeight) {
					continue;
				}
				var sum = group.sum();
				if (sum + weight <= groupCapacity) {
					group.push(weight);
				}
			}
			return if (group.sum() == groupCapacity) group else null;
		}).filter(group -> group != null);
		return firstGroupOptions.min(group -> group.length).list.min(group -> group.product()).value;
	}
}
