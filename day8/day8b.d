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

long accumulator;
void main()
{        
    auto instructions = 
        File("input.txt")
        .byLine
        .map!(parse)
        .array;
    
    foreach(instruction; instructions)
    {
        if(instruction.opCode == "nop")
        {
            instruction.opCode = "jmp";
            if(runProgram(instructions))
                break;
            instruction.opCode = "nop";
        }
        else if(instruction.opCode == "jmp")
        {
            instruction.opCode = "nop";
            if(runProgram(instructions))
                break;
            instruction.opCode = "jmp";
        }
    }
    writeln(accumulator);
}

bool runProgram(Instruction[] instructions)
{
    accumulator = 0;
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

        if(instructionPointer >= instructions.length)
        {
            return true;
        }
        current = instructions[instructionPointer];
    }
    
    foreach(instruction; instructions)
    {
        instruction.visited = false;
    }
    
    return false;
}

Instruction parse(TString)(TString text)
{
    auto splitText = text.split;
    auto instruction = splitText[0].idup;
    auto argument = splitText[1].to!int;
    return new Instruction(instruction, argument);
}
