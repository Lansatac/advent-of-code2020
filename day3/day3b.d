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
        .byLineCopy(KeepTerminator.no, newline)
        .array
        .map!(line=>line.cycle);
    auto trees = [
       treePattern.treesEncountered(1,1),
        treePattern.treesEncountered(3,1),
        treePattern.treesEncountered(5,1),
        treePattern.treesEncountered(7,1),
        treePattern.treesEncountered(1,2),
    ];

    writeln(trees);
    writeln(trees.fold!((long a,c)=>a *= c));
}

unittest
{
    assert(["..",
            ".."].treesEncountered(1,1) == 0);
    assert(["##",
            "##"].treesEncountered(1,1) == 2);
    assert(["#.",
            ".#"].treesEncountered(1,1) == 2);
    assert([".#",
            "#."].treesEncountered(1,1) == 0);
    assert(["..",
            ".#"].treesEncountered(1,1) == 1);

    assert(["....",
            "...."].treesEncountered(3,1) == 0);
    assert(["....",
            "...#"].treesEncountered(3,1) == 1);

            
    assert(["....",
            "#...",
            "#..."].treesEncountered(0,2) == 1);

assert(`..##.........##.........##.........##.........##.........##.......
#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....
.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
.#........#.#........#.#........#.#........#.#........#.#........#
#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
#...##....##...##....##...##....##...##....##...##....##...##....#
.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#`.split("\n").treesEncountered(3,1) == 7);
}

int treesEncountered(TRange)(TRange treePattern, int x, int y)
{
    int trees = 0;
    int coord = 0;
    foreach (line; treePattern.stride(y))
    {
        if(line.drop(coord).front == '#')
            trees += 1;
        coord += x;
    }
    return trees;
}