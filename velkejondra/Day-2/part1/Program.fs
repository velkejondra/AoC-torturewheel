﻿// For more information see https://aka.ms/fsharp-console-apps

open System.Text.RegularExpressions
let lines = System.IO.File.ReadAllLines("day2.txt")

let maxRed = 12
let maxGreen = 13
let maxBlue = 14

let parsedLines = 
    lines
    |> Array.map (fun line -> line[line.IndexOf(": ")+2..])


let getMaxMatch(matchCollection:MatchCollection) =
    matchCollection
    |> Seq.map(fun m ->int (m.Groups.Item(1).Value))
    |> Seq.maxBy(fun value -> int value)

let max_per_color =
    parsedLines
    |> Array.map(fun line -> [|Regex.Matches(line, @"(\d+) red");
                                       Regex.Matches(line, @"(\d+) green");
                                       Regex.Matches(line, @"(\d+) blue")|])
    |> Array.map(fun (arr) -> arr|> Array.map(fun m -> getMaxMatch(m)))


let sum = 
    max_per_color
    |> Array.zip [| 1 .. parsedLines.Length|]
    |> Array.filter(fun (index, arr) -> arr[0] <= maxRed && arr[1] <= maxGreen && arr[2] <= maxBlue)
    |> Array.map(fun (index, arr) -> index)
    |> Array.sum



printfn "%A" sum