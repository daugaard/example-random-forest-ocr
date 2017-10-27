require './dataset_reader.rb'
require 'pycall/import'

include PyCall::Import
pyfrom :'sklearn.ensemble', import: :RandomForestClassifier

test_labels = DatasetReader.read_labels( "data/t10k-labels.idx1-ubyte" )
test_images = DatasetReader.read_images( "data/t10k-images.idx3-ubyte" )
rows, columns = DatasetReader.read_rows_columns( "data/t10k-images.idx3-ubyte" )

puts "Labels: #{test_labels.size}, Images: #{test_images.size}, Rows: #{rows}, Columns: #{columns}"

train_labels = DatasetReader.read_labels( "data/train-labels.idx1-ubyte" )
train_images = DatasetReader.read_images( "data/train-images.idx3-ubyte" )

puts "Labels: #{train_labels.size}, Images: #{train_images.size}"

# Initialize a RandomForestClassifier
clf = RandomForestClassifier.new()

# Fit with training data
clf.fit(train_images, train_labels)

# Score our fit using the test data
classification_score = clf.score(test_images,test_labels)
puts "Prediction score for Random Forest classifier #{(classification_score*100).round(2)}%"

# Do a prediction for one sample
sample = 123
puts "Prediction #{clf.predict([test_images[sample]])} - Correct label: #{test_labels[sample]}"
# Reshape back to 2 dimmensions and print
reshaped = test_images[sample].each_slice(28).to_a
puts test_labels[sample]
reshaped.each do |r|
  puts r.inspect
end
