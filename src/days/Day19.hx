package days;

class Day19 {
	static function parse(input:String) {
		var replacements = new Map<String, Array<String>>();
		var lines = input.split("\n");
		for (line in lines) {
			if (line.length == 0) {
				break;
			}
			var parts = line.split(" => ");
			var options = replacements[parts[0]];
			if (options == null) {
				options = [];
			}
			options.push(parts[1]);
			replacements[parts[0]] = options;
		}
		return {
			replacements: replacements,
			medicine: lines[lines.length - 1]
		}
	}

	public static function countDistinctMolecules(input:String):Int {
		var data = parse(input);
		var molecules = new Map<String, Bool>();
		for (i in 0...data.medicine.length) {
			function replace(from:String) {
				var options = data.replacements[from];
				if (options == null) {
					return;
				}
				for (option in options) {
					var molecule = data.medicine.substring(0, i) + option + data.medicine.substr(i + from.length);
					molecules[molecule] = true;
				}
			}
			var s1 = data.medicine.charAt(i);
			var s2 = data.medicine.charAt(i + 1);
			replace(s1);
			replace(s1 + s2);
		}
		return molecules.count(i -> i);
	}
}

private typedef Data = {
	final replacements:Map<String, String>;
	final medicine:String;
}
