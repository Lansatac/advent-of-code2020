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

enum EntryMatcher = ctRegex!(r"(\w+):([^\s]+)");


void main()
{
    auto passports = 
        readText("input.txt");

        writeln(validPassports(passports));
}

unittest
{
int valid = `ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in`.validPassports("\n\n");
    assert(valid == 2);
}

int validPassports(string passportData, string separator = (newline ~ newline))
{
    return passportData
        .split(separator)
        .filter!(validPassport)
        .count
        ;
}

unittest
{
    assert(
`ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm`.validPassport == true);

    assert(
`iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929`.validPassport == false);

    assert(
`hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm`.validPassport == true);

    assert(
`hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in`.validPassport == false);
}

bool validPassport(string passportData)
{
    auto passport = passportData.matchAll(EntryMatcher).convertToDictionary;
    return 
        "byr" in passport &&
        "iyr" in passport &&
        "eyr" in passport &&
        "hgt" in passport &&
        "hcl" in passport &&
        "ecl" in passport;
        
}

string[string] convertToDictionary(TString)(RegexMatch!TString match)
{
        string[string] passport;
        foreach(capture;match)
        {
            passport[capture[1]] = capture[2];
        }
        return passport;
}