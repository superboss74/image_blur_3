# This class would be used to manipulate an image
# It uses a blur(distance) method that would blur by the
# Manhattan distance specified
class Image
  attr_accessor :array

  def initialize(array)
    @array = array
    @ones = []
  end

  def num_rows
    @array.length
  end

  def num_cols(row)
    @array[row].length
  end

  def inbound(row, col)
    col <= (@array[row - 1].length - 1)
  end

  def set_pixel_north(row, col)
    @array[row - 1][col] = 1 if row - 1 >= 0 && inbound(row, col)
  end

  def set_pixel_south(row, col)
    @array[row + 1][col] = 1 if (row + 1 < num_rows - 1) && inbound(row, col)
  end

  def set_pixel_west(row, col)
    @array[row][col - 1] = 1 if col - 1 >= 0
  end

  def set_pixel_east(row, col)
    @array[row][col + 1] = 1 if col + 1 < num_cols(row)
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

image.blur(5)
