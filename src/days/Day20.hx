package days;

class Day20 {
	public static function findLowestHouseNumber(target:Int):Int {
		var presents = 0;
		var house = Std.int((target / 10) / 4.3);
		do {
			house++;
			presents = 0;
			for (elf in 1...house + 1) {
				if (house % elf == 0) {
					presents += elf * 10;
				}
			}
		} while (presents < target);
		return house;
	}

	public static function findLowestHouseNumber2(target:Int):Int {
		var visits = [];
		var presents = 0;
		var house = 0;
		do {
			visits[house] = 0;
			house++;
			presents = 0;
			for (elf in 1...house + 1) {
				if (visits[elf - 1] < 50 && house % elf == 0) {
					presents += elf * 11;
					visits[elf - 1]++;
				}
			}
		} while (presents < target);
		return house;
	}
}
