<?php

function parse_line($line): int {
    $number1 = preg_replace('/[^\d]/', '', $line);
    $firstDigit = substr($number1, 0, 1);
    $lastDigit = substr($number1, -1, 1);

    return intval($firstDigit . $lastDigit);
}

$line = "";
$sum = 0;

while(!feof(STDIN)) {
    $line = fgets(STDIN);
    $sum += parse_line($line);
}

echo $sum;
?>