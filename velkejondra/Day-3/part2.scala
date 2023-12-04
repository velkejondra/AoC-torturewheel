import scala.collection.mutable
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

  val gears: mutable.Map[(Int, Int), List[Number]] = mutable.Map.empty

  for (number <- numbers) {
    val row = number.row
    val col = number.col
    val size = number.size
    var coordinates = for {
      i <- List(row - 1, row + 1)
      j <- col - 1 to col + size
    } yield (i, j)

    coordinates = coordinates ++ List((row, col - 1), (row, col + size))

    val containsSymbol = coordinates.exists { case (i, j) => lines.lift(i).exists(
      line => line.lift(j).exists(
        char => !char.isDigit && char != '.'
      ))
    }

    coordinates.foreach((i, j) => lines.lift(i).foreach(
      line => line.lift(j).foreach(
        char => if (char == '*') gears.update((i, j), gears.getOrElse((i, j), List.empty) :+ number)
      )
    ))

  }

  val result = gears.values.filter(_.length == 2).map(_.map(_.value).product).sum

  println(result)

}
