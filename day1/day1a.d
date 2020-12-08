import std.stdio;
import std.conv;
import std.algorithm;
import std.array;
import std.ascii;

void main()
{    
    const numbers = 
    File("input.txt")
    .byLine(KeepTerminator.no, newline)
    .map!(to!int).array;    // [1,2,3,4]

    foreach(index, first; numbers)
    {
        foreach(second; numbers[index .. $])
        {
            if(first + second == 2020)
            {
                writeln(first * second);
                return;
            }
        }
    }
}