package days;

class Day14 {
	static function parse(input:String):Array<Reindeer> {
		var regex = ~/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./;
		return input.split("\n").map(function(line) {
			if (!regex.match(line)) {
				throw 'no match';
			}
			return {
				name: regex.matched(1),
				speed: regex.int(2),
				flyingTime: regex.int(3),
				restTime: regex.int(4)
			};
		});
	}

	public static function calculateWinningScore(input:String, seconds:Int, scoringSystem:ScoringSystem):Int {
		var reindeerStats = parse(input);
		var raceStatus = [
			for (reindeer in reindeerStats)
				reindeer => {
					distance: 0,
					flying: true,
					timeElapsed: 0,
					points: 0
				}
		];
		var statuses = [for (status in raceStatus) status];
		function furthtestReindeer() {
			return statuses.max(s -> s.distance);
		}
		for (_ in 0...seconds) {
			for (reindeer in reindeerStats) {
				var status = raceStatus[reindeer];
				if (status.flying) {
					status.distance += reindeer.speed;
				}
				status.timeElapsed++;
				var relevantLimit = if (status.flying) reindeer.flyingTime else reindeer.restTime;
				if (status.timeElapsed >= relevantLimit) {
					status.flying = !status.flying;
					status.timeElapsed = 0;
				}
			}
			if (scoringSystem == New) {
				for (status in furthtestReindeer().list) {
					status.points++;
				}
			}
		}
		return if (scoringSystem == Old) furthtestReindeer().value else statuses.max(s -> s.points).value;
	}
}

private typedef Reindeer = {
	final name:String;
	final speed:Int;
	final flyingTime:Int;
	final restTime:Int;
}

enum ScoringSystem {
	Old;
	New;
}
