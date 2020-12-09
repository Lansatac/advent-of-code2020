import std.stdio;
import std.algorithm;
import std.ascii;
import std.array;
import std.typecons;
import std.conv;

void main()
{
    auto passwords = 
        File("input.txt")
        .byLine(KeepTerminator.no, newline)
        .map!(pw=>pw.split(": "))
        .map!(pw=>
            {
                auto password = pw[1];
                auto rulePart = pw[0].split(" ");
                auto minMax = rulePart[0].split("-");
                auto min = minMax[0].to!int;
                auto max = minMax[1].to!int;
                auto letter = rulePart[1];
                auto matchCount = password[min - 1] == letter[0] ? 1 : 0;
                matchCount += password[max - 1] == letter[0] ? 1 : 0;
                return tuple!("rules", "password", "matching")(
                    tuple!("min", "max", "letter")(min, max, letter),
                    password,
                    matchCount == 1);
            }
        )//[("1-2 a", "abc", 1)]
        .map!(x=>x()) // Can't figure out how to disambiguate the lambda above :(
        .count!((x, y) => x.matching == y)(true)
            ;

    writeln(passwords);

}

