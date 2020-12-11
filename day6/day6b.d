import std.stdio;
import std.file;
import std.algorithm;
import std.ascii;
import std.array;
import std.typecons;
import std.conv;
import std.range;
import std.regex;
import std.uni;
import std.string;

void main()
{        
    auto answers = 
        readText("input.txt")
        .split(newline ~ newline)
        .map!(group=>group
                    .split(newline)
                    .map!(answer=>answer.array.sort.array)
                    .fold!((c,x){return setIntersection(c,x).array;})
             );

    writeln(answers.map!(x=>x.count).sum);
}