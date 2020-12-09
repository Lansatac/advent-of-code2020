import std.stdio;
import std.algorithm;
import std.ascii;
import std.array;
import std.typecons;
import std.conv;
import std.range;

void main()
{
    auto treePattern = 
        File("input.txt")
        .byLine(KeepTerminator.no, newline)
        .map!(line=>line.cycle);

    int trees = 0;
    int coord = 0;
    foreach (line; treePattern)
    {
        if(line.drop(coord).front == '#')
            trees += 1;
        coord += 3;
    }
    writeln(trees);
}