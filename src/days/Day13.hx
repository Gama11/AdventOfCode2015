package days;

class Day13 {
	static function parse(input:String) {
		var potentialHappiness = new Map<String, Map<String, Int>>();
		var regex = ~/^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+).$/;
		for (line in input.split("\n")) {
			if (!regex.match(line)) {
				throw "no match";
			}
			var name = regex.matched(1);
			var person = potentialHappiness[name];
			if (person == null) {
				person = new Map();
			}
			var lose = regex.matched(2) == "lose";
			var units = regex.int(3);
			if (lose) {
				units *= -1;
			}
			var neighbour = regex.matched(4);
			person[neighbour] = units;
			potentialHappiness[name] = person;
		}
		return potentialHappiness;
	}

	public static function findOptimalNetHappiness(input:String):Int {
		var potentialHappiness = parse(input);
		var names = [for (name in potentialHappiness.keys()) name];
		return names.permutations().map(function(arrangement) {
			var sum = 0;
			for (i in 0...arrangement.length) {
				var a = arrangement[i];
				var b = arrangement[(i + 1) % arrangement.length];
				sum += potentialHappiness[a][b];
				sum += potentialHappiness[b][a];
			}
			return sum;
		}).max(i -> i).value;
	}
}
