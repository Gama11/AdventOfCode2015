package days;

class Day07 {
	static function parse(input:String):Circuit {
		var circuit = new Circuit();
		for (line in input.split("\n")) {
			var parts = line.split(" -> ");
			var lhs = parts[0].split(" ");
			function input(s) {
				return if (~/^\d+$/.match(s)) Value(Std.parseInt(s)) else Wire(s);
			}
			circuit[parts[1]] = switch lhs {
				case [a]: input(a);
				case [a, "AND", b]: And(input(a), input(b));
				case [a, "OR", b]: Or(input(a), input(b));
				case [a, "LSHIFT", b]: Lshift(input(a), input(b));
				case [a, "RSHIFT", b]: Rshift(input(a), input(b));
				case ["NOT", a]: Not(input(a));
				case _: throw "invalid wiring";
			};
		}
		return circuit;
	}

	public static function getSignal(input:String, wire:Wire):Int {
		var circuit = parse(input);
		var signals = new Map<Wire, Int>();
		function signal(connnection:Connection):Int {
			function wire(w:Wire) {
				var value = signals[w];
				if (value == null) {
					value = signal(circuit[w]);
				}
				return signals[w] = value;
			}
			return switch connnection {
				case null: throw '$wire is not connected';
				case Value(value): value;
				case Wire(w): wire(w);
				case And(a, b): signal(a) & signal(b);
				case Or(a, b): signal(a) | signal(b);
				case Lshift(a, b): signal(a) << signal(b);
				case Rshift(a, b): signal(a) >>> signal(b);
				case Not(a): Std.int(Math.pow(2, 16)) - signal(a) - 1;
			}
		}
		return signal(circuit[wire]);
	}
}

private typedef Circuit = Map<String, Connection>;

private enum Connection {
	Value(value:Int);
	Wire(wire:Wire);
	And(a:Connection, b:Connection);
	Or(a:Connection, b:Connection);
	Lshift(a:Connection, b:Connection);
	Rshift(a:Connection, b:Connection);
	Not(a:Connection);
}

private typedef Wire = String;
