<?php

function get_number($numb)
{
    $words = ['zero' => '0',
        'one' => '1',
        'two' => '2',
        'three' => '3',
        'four' => '4',
        'five' => '5',
        'six' => '6',
        'seven' => '7',
        'eight' => '8',
        'nine' => '9'
    ];
    if (!is_numeric($numb)) {
        $numb = $words[$numb];
    }
    return $numb;
}

function parse_line($line): int
{
    $matches = array();
    preg_match_all('/(\d|one|two|three|four|five|six|seven|eight|nine)/i', $line, $matches);
    $result = $matches[0];

    $fdigit = get_number($result[0]);
    $ldigit = get_number($result[count($result) - 1]);

    return intval($fdigit . $ldigit);
}

$line = "";
$sum = 0;
while (!feof(STDIN)) {
    $line = fgets(STDIN);
    $sum += parse_line($line);
}
echo $sum;
?>