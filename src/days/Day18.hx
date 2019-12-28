package days;

import Util.Point;
import Util.Direction;
import haxe.ds.HashMap;

class Day18 {
	public static function countLitLights(input:String, steps:Int, alwaysOn:Bool):Int {
		var grid = Util.parseGrid(input);
		var lights:HashMap<Point, Light> = grid.map;
		if (alwaysOn) {
			lights[new Point(0, 0)] = AlwaysOn;
			lights[new Point(grid.width - 1, 0)] = AlwaysOn;
			lights[new Point(0, grid.height - 1)] = AlwaysOn;
			lights[new Point(grid.width - 1, grid.height - 1)] = AlwaysOn;
		}
		for (_ in 0...steps) {
			var next = new HashMap();
			for (pos => light in lights) {
				var lit = Direction.all.count(dir -> lights[pos + dir].isOn());
				next[pos] = switch light {
					case On if (lit == 2 || lit == 3): On;
					case On: Off;
					case Off if (lit == 3): On;
					case Off: Off;
					case AlwaysOn: AlwaysOn;
				}
			}
			lights = next;
		}
		return [for (light in lights) if (light.isOn()) light].length;
	}
}

private enum abstract Light(String) from String {
	var On = "#";
	var Off = ".";
	var AlwaysOn = "A";

	public function isOn() {
		return this == On || this == AlwaysOn;
	}
}
