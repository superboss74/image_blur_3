# This class would be used to manipulate an image
# It uses a blur(distance) method that would blur by the
# Manhattan distance specified
class Image
  attr_accessor :array

  def initialize(array)
    @array = array
    @ones = []
  end

  def in_bound?(row, col)
    row_range = 0...@array.length
    return false if row > @array.length - 1
      col_range = 0...@array[row].length
    row_range.cover?(row) && col_range.cover?(col)
  end

  def set_pixel_north(row, col)
    if in_bound?(row - 1, col)
      @array[row - 1][col] = 1
    end
  end

  def set_pixel_south(row, col)
    if in_bound?(row + 1, col)
      @array[row + 1][col] = 1
    end
  end

  def set_pixel_west(row, col)
    if in_bound?(row, col - 1)
      @array[row][col - 1] = 1
    end
  end

  def set_pixel_east(row, col)
    if in_bound?(row, col + 1)
      @array[row][col + 1] = 1
    end
  end

  def blur_by_one(row_index, col_index)
    set_pixel_north(row_index, col_index)
    set_pixel_west(row_index, col_index)
    set_pixel_east(row_index, col_index)
    set_pixel_south(row_index, col_index)
  end

  def indexer
    @array.each_with_index do |row, row_index|
      row.each_with_index do |pixel, col_index|
        @ones.push [row_index, col_index] if pixel == 1
      end
    end
    @ones
  end

  def transform
    indexer
    @ones.each do |pair|
      row_index, col_index = pair
      blur_by_one(row_index, col_index)
    end
  end

  def manhattan_image
    @array.each do |row|
      row.each do |pixel|
        print pixel
      end
      puts
    end
  end

  def blur(distance)
    distance.times do
      transform
    end
    manhattan_image
  end
end

image = Image.new(
  [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]
)

image.blur(2)
