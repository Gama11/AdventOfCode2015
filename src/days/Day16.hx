package days;

class Day16 {
	static function parse(input:String):Array<Compounds> {
		return input.split("\n").map(function(line) {
			var parts = line.split(" ");
			function key(i) {
				return parts[i].substr(0, parts[i].length - 1);
			}
			function value(i) {
				return Std.parseInt(parts[i]);
			}
			return [key(2) => value(3), key(4) => value(5), key(6) => value(7)];
		});
	}

	public static function findSueNumber(input:String, query:Compounds):Int {
		var sues = parse(input);
		for (i in 0...sues.length) {
			var sue = sues[i];
			var keys = [for (key in sue.keys()) key];
			if (!keys.exists(key -> sue[key] != query[key])) {
				return i + 1;
			}
		}
		return null;
	}

	public static function findRealSueNumber(input:String, query:Compounds):Int {
		var sues = parse(input);
		for (i in 0...sues.length) {
			var sue = sues[i];
			var match = true;
			for (compound => count in sue) {
				var reading = query[compound];
				switch compound {
					case "cats" | "trees":
						if (count <= reading) {
							match = false;
						}
					case "pomeranians" | "goldfish":
						if (count >= reading) {
							match = false;
						}
					case _ if (count != reading):
						match = false;
					case _:
				}
			}
			if (match) {
				return i + 1;
			}
		}
		return null;
	}
}

private typedef Compounds = Map<String, Int>;
