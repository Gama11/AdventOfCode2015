package days;

import haxe.ds.HashMap;
import Util.Point;

class Day06 {
	static function parse(input:String):Array<Instruction> {
		return input.split("\n").map(function(line) {
			var r = ~/(.*?) (\d+),(\d+) through (\d+),(\d+)/;
			if (!r.match(line)) {
				throw "regex not matched";
			}
			return {
				area: {
					min: new Point(r.int(2), r.int(3)),
					max: new Point(r.int(4), r.int(5))
				},
				action: switch r.matched(1) {
					case "toggle": Toggle;
					case "turn on": TurnOn;
					case "turn off": TurnOff;
					case _: throw "invalid action";
				}
			};
		});
	}

	static function processInstructions(input:String, process:(pos:Point, action:Action) -> Void) {
		for (instruction in parse(input)) {
			var area = instruction.area;
			for (x in area.min.x...area.max.x + 1) {
				for (y in area.min.y...area.max.y + 1) {
					process(new Point(x, y), instruction.action);
				}
			}
		}
	}

	public static function countLitLights(input:String):Int {
		var lights = new HashMap<Point, Bool>();
		processInstructions(input, function(pos, action) {
			lights[pos] = switch action {
				case Toggle: !lights[pos];
				case TurnOn: true;
				case TurnOff: false;
			};
		});
		return [for (light in lights) if (light) light].length;
	}

	public static function countLitLights2(input:String):Int {
		var lights = new HashMap<Point, Int>();
		processInstructions(input, function(pos, action) {
			var brightness = lights[pos];
			if (brightness == null) {
				brightness = 0;
			}
			lights[pos] = brightness + switch action {
				case Toggle: 2;
				case TurnOn: 1;
				case TurnOff if (brightness > 0): -1;
				case _: 0;
			};
		});
		return [for (brightness in lights) brightness].sum();
	}
}

private typedef Area = {
	final min:Point;
	final max:Point;
}

private enum Action {
	Toggle;
	TurnOn;
	TurnOff;
}

private typedef Instruction = {
	final area:Area;
	final action:Action;
}
