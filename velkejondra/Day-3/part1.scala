import scala.io.Source

case class Number(row: Int, col: Int, value: Int, size: Int)

@main
def main(): Unit = {
  val lines: List[String] = Source.fromFile("input.txt").getLines.toList

  // match numbers on line with regex
  val numbers: List[Number] = lines.zipWithIndex.flatMap { (line, row) =>
    val regex = raw"(\d+)".r
    regex.findAllMatchIn(line).toList.map { (matchData) =>
      Number(row, matchData.start, matchData.group(1).toInt, matchData.group(1).length)
    }
  }

  val sum: Int = numbers.map { number =>
    val row = number.row
    val col = number.col
    val size = number.size
    var coordinates = for {
      i <- List(row - 1, row + 1)
      j <- col - 1 to col + size
    } yield (i, j)

    coordinates = coordinates ++ List((row, col - 1), (row, col + size))

    // check if coordinates contain a symbol - use functional approach of discarding non-existing coordinates
    val containsSymbol = coordinates.exists { case (i, j) => lines.lift(i).exists(
      line => line.lift(j).exists(
        char => !char.isDigit && char != '.'
      ))
    }

    if (containsSymbol) number.value else 0
  }.sum

  println(sum)
}
