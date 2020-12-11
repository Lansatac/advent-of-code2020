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

class Instruction
{
    this(string opCode, int argument)
    {
        this.opCode = opCode;
        this.argument = argument;
        this.visited = false;
    }
    string opCode;
    int argument;
    bool visited;
}

void main()
{        
    auto instructions = 
        File("input.txt")
        .byLine
        .map!(parse)
        .array;
    
    long accumulator;
    int instructionPointer = 0;
    Instruction current = instructions[instructionPointer];
    while(current.visited == false)
    {
        current.visited = true;
        switch(current.opCode)
        {
            case "acc":
                accumulator += current.argument;
                goto case;
            case "nop":
                instructionPointer += 1;
                break;
            case "jmp":
                instructionPointer += current.argument;
            break;
            default:
                assert(0);
        }

        current = instructions[instructionPointer];
    }
    writeln(accumulator);
}

Instruction parse(TString)(TString text)
{
    auto splitText = text.split;
    auto instruction = splitText[0].idup;
    auto argument = splitText[1].to!int;
    return new Instruction(instruction, argument);
}
