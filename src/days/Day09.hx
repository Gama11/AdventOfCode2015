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

	public static function findRoute(input:String, routeKind:RouteKind):Int {
		var distances = parse(input);
		function size<T>(map:Map<String, T>) {
			return [for (_ in map) _].length;
		}
		var starts = [for (location in distances.keys()) new State(location, [], 0)];
		var maxDistance = 0;
		var result = AStar.search(starts, function(state) {
			return if (routeKind == Shortest) {
				size(distances) == size(state.visited);
			} else {
				maxDistance = Std.int(Math.max(maxDistance, state.distanceTraveled));
				false;
			}
		}, s -> size(distances) - size(s.visited), function(state) {
			var moves = [];
			for (target => distance in distances[state.location]) {
				if (!state.visited[target]) {
					moves.push({
						cost: distance,
						state: new State(target, state.visited.copy(), state.distanceTraveled + distance)
					});
				}
			}
			return moves;
		});
		return if (routeKind == Shortest) result.score else maxDistance;
	}
}

private class State {
	public final location:String;
	public final visited:Map<String, Bool>;
	public final distanceTraveled:Int;

	public function new(location, visited, distanceTraveled) {
		this.location = location;
		this.visited = visited;
		this.distanceTraveled = distanceTraveled;
		visited[location] = true;
	}

	public function hashCode() {
		return location + " " + visited;
	}
}

enum RouteKind {
	Shortest;
	Longest;
}
