package days;

class Day23 {
	static function parse(input:String):Array<Instruction> {
		return input.split("\n").map(function(line) {
			line = line.replace(",", "").replace("+", "");
			return switch line.split(" ") {
				case ["hlf", r]: Halve(r);
				case ["tpl", r]: Triple(r);
				case ["inc", r]: Increment(r);
				case ["jmp", offset]: Jump(Std.parseInt(offset));
				case ["jie", r, offset]: JumpIfEven(r, Std.parseInt(offset));
				case ["jio", r, offset]: JumpIfOne(r, Std.parseInt(offset));
				case _: throw 'invalid instruction';
			}
		});
	}

	public static function execute(input:String):Map<Register, Int> {
		var program = parse(input);
		var registers = [A => 0, B => 0];
		var i = 0;
		while (i >= 0 && i < program.length) {
			switch program[i] {
				case Halve(r):
					registers[r] = Std.int(registers[r] / 2);
					i++;
				case Triple(r):
					registers[r] *= 3;
					i++;
				case Increment(r):
					registers[r]++;
					i++;

				case Jump(offset):
					i += offset;
				case JumpIfEven(r, offset) if (registers[r] % 2 == 0):
					i += offset;
				case JumpIfOne(r, offset) if (registers[r] == 1):
					i += offset;
				case _:
					i++;
			}
		}
		return registers;
	}
}

enum abstract Register(String) from String {
	var A = "a";
	var B = "b";
}

private enum Instruction {
	Halve(r:Register);
	Triple(r:Register);
	Increment(r:Register);
	Jump(offset:Int);
	JumpIfEven(r:Register, offset:Int);
	JumpIfOne(r:Register, offset:Int);
}
