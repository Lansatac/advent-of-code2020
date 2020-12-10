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
    auto seats = 
        File("input.txt")
        .byLine
        .map!(strip)
        .map!(seatID)
        .array
        .sort
        ;
    int prev = seats.front;
    foreach(seat; seats.drop(1))
    {
        if(seat != prev + 1)
        {
            writeln(prev + 1);
            break;
        }
        prev = seat;
    }
}

unittest
{
    assert(seatID("FBFBBFFRLR") == 357);
}

int seatID(TString)(TString bsp)
{
    auto rowString = bsp[0..7];
    auto columnString =   bsp[$-4 .. $];
    ubyte row = decode(rowString, 'B');
    ubyte column = decode(columnString, 'R');

    return row * 8 + column;
}

byte decode(TString, TChar)(TString str, TChar code)
{
    ubyte val = 0;
    foreach(c;str)
    {
        val <<= 1;
        if(c == code)
            val += 1;
    }
    return val;
}