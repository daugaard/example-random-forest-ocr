# Dataset reader helper to read datasets in the format described: http://yann.lecun.com/exdb/mnist/
class DatasetReader
  def self.read_labels file
    labels = []
    File.open(file) do |f|

      magic_number = f.read(4).unpack("l>").first # Unpack first 4 bytes into integer big endian
      number_of_labels = f.read(4).unpack("l>").first # Unpack next 4 bytes into integer big endian

      1.upto(number_of_labels) do |n| # For each label
        labels.push f.read(1).unpack("c").first # Unpack byte and return as byte
      end
    end

    return labels
  end

  def self.read_images file
    images = []
    rows, columns = nil

    File.open(file) do |f|

      magic_number = f.read(4).unpack("l>").first # Unpack first 4 bytes into integer big endian
      number_of_images = f.read(4).unpack("l>").first # Unpack next 4 bytes into integer big endian
      rows = f.read(4).unpack("l>").first # Unpack next 4 bytes into integer big endian
      columns = f.read(4).unpack("l>").first # Unpack next 4 bytes into integer big endian

      1.upto(number_of_images) do |n| # For each image
        image_data = f.read(rows*columns).unpack("C*")
        images.push image_data
      end
    end

    return images
  end

  def self.read_rows_columns file
    rows, columns = nil

    File.open(file) do |f|
      magic_number = f.read(4).unpack("l>").first # Unpack first 4 bytes into integer big endian
      number_of_images = f.read(4).unpack("l>").first # Unpack next 4 bytes into integer big endian
      rows = f.read(4).unpack("l>").first # Unpack next 4 bytes into integer big endian
      columns = f.read(4).unpack("l>").first # Unpack next 4 bytes into integer big endian
    end

    return rows, columns
  end
end
