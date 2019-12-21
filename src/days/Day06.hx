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

	public static function countLitLights(input:String):Int {
		var lights = new HashMap<Point, Bool>();
		for (instruction in parse(input)) {
			var area = instruction.area;
			for (x in area.min.x...area.max.x + 1) {
				for (y in area.min.y...area.max.y + 1) {
					var pos = new Point(x, y);
					lights.set(pos, switch instruction.action {
						case Toggle: !lights.get(pos);
						case TurnOn: true;
						case TurnOff: false;
					});
				}
			}
		}
		return [for (light in lights) if (light) light].length;
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
