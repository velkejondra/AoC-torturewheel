$star_array = []

def load_input()
  input_matrix = []
  input = gets.chomp
  while !input.empty? do
    input_matrix << input.chars
    input = gets.chomp
  end
  input_matrix
end

def check_elem(mat, i, j, num)
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, -1], [1, 1]]
  flag = false
  directions.each do |di, dj|
    ni, nj = i + di, j + dj
    if ni >= 0 && ni < mat.size && nj >= 0 && nj < mat[i].size
      if mat[ni][nj].match(/\d/)
        next
      end
      if mat[ni][nj] != '.'
        if mat[ni][nj] == '*'
          $star_array << {"v": num, "x": ni, "y": nj}
        end
        flag=true
        break
      end
    end
  end
  flag
end

def check_number(mat, i, j)
  num_arr = []
  for x in j...mat[i].size
    if mat[i][x].match(/\d/)
      num_arr << mat[i][x]
    else
      break
    end
  end
  n = num_arr.join.to_i
  flag = check_neigbours(mat, i, j, num_arr, n)
  if flag
    num_arr.join.to_i
  else
    -1
  end
end

def check_neigbours(mat, i, j, num_arr, n)
  flag = false
  for x in 0...num_arr.size
    flag = check_elem(mat, i, j+x, n)
    if flag
      break
    end
  end
  flag
end

def group_by_coordinates(array)
  hash = Hash.new { |h, k| h[k] = [] }
  array.each do |item|
    hash[[item[:x], item[:y]]] << item[:v]
  end
  hash.values.select { |arr| arr.size == 2 }.map { |arr| arr.reduce(:*) }.sum
end

def iterate_array(mat)
  sum = 0
  for i in 0...mat.size
    j = 0
    while j < mat[i].size
      if mat[i][j].match(/\d/)
        number = check_number(mat, i, j)
        if number == -1
          j = j+1
          next
        end
        j = j + number.to_s.length
        sum = sum + number
      else
        j = j+1
      end
    end
  end
  group_by_coordinates($star_array)
end

puts iterate_array(load_input)
