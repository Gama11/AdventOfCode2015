package days;

class Day09 {
	static function parse(input:String) {
		var distances = new Map<String, Map<String, Int>>();
		for (line in input.split("\n")) {
			var parts = line.split(" ");
			var a = parts[0];
			var b = parts[2];
			var distance = Std.parseInt(parts[4]);
			function add(from, to, distance) {
				var paths = distances[from];
				if (paths == null) {
					paths = new Map();
				}
				paths[to] = distance;
				distances[from] = paths;
			}
			add(a, b, distance);
			add(b, a, distance);
		}
		return distances;
	}

	public static function findShortestRoute(input:String):Int {
		var distances = parse(input);
		function size<T>(map:Map<String, T>) {
			return [for (_ in map) _].length;
		}
		var starts = [for (location in distances.keys()) new State(location, [])];
		return AStar.search(starts, s -> size(distances) == size(s.visited), s -> size(distances) - size(s.visited), function(state) {
			var moves = [];
			for (target => distance in distances[state.location]) {
				if (!state.visited[target]) {
					moves.push({
						cost: distance,
						state: new State(target, state.visited.copy())
					});
				}
			}
			return moves;
		}).score;
	}
}

private class State {
	public final location:String;
	public final visited:Map<String, Bool>;

	public function new(location, visited) {
		this.location = location;
		this.visited = visited;
		visited[location] = true;
	}

	public function hashCode() {
		return location + " " + visited;
	}
}
