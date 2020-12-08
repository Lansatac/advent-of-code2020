import std.stdio;
import std.algorithm;
import std.ascii;
import std.array;
import std.typecons;

void main()
{
    auto passwords = 
        File("input.txt")
        .byLine(KeepTerminator.no, newline)
        .map!(pw=>pw.split(": "))
        .map!(pw=>tuple!("rules", "password")(
            pw[0].split(" "),
            pw[1]
            ))
        .map!(x);

    foreach (pw; passwords)
    {
        writeln(pw);
    }
}

