# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'activerecord-import'

sr_dir = Rake.application.original_dir + "/db/sr25/sr25/sr25"

def parse_line(line)
  data_array = []
  line.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').split('^').each do |data|
    item = data.chomp().chomp('~').reverse().chomp().chomp('~').reverse().chomp
    data_array << item
  end
  data_array
end

#############################################################################
print 'Importing ''foods'''
count = 0
data = []
File.foreach("#{sr_dir}/FOOD_DES.txt") do |line|
  data_array = parse_line(line)

  # fix "numbers" that start with '0' so they won't be octal
  data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
  data_array[1] = data_array[1][1..-1] if data_array[1][0] == '0'
  data_array[0] = data_array[0].to_i
  data_array[1] = data_array[1].to_i

  data << FoodNdb::Food.new do |x|
    x.nutrient_databank_number = data_array[0]
    x.food_group_code          = data_array[1]
    x.long_description         = data_array[2]
    x.short_description        = data_array[3].downcase().capitalize
    x.common_names             = data_array[4]
    x.manufacturer_name        = data_array[5]
    x.survey                   = data_array[6] == 'Y' ? true : false
    x.refuse_description       = data_array[7]
    x.refuse_percent           = data_array[8]
    x.scientific_name          = data_array[9]
    x.n_factor                 = data_array[10]
    x.protein_factor           = data_array[11]
    x.fat_factor               = data_array[12]
    x.carbohydrate_factor      = data_array[13]
  end

  count += 1
  if count % 100 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::Food.import data
puts FoodNdb::Food.count

#############################################################################
print 'Importing ''food groups'''
count = 0
data = []
File.foreach("#{sr_dir}/FD_GROUP.txt") do |line|
  data_array = parse_line(line)
  # fix "numbers" that start with '0' so they won't be octal
  data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
  data_array[0] = data_array[0].to_i

  data << FoodNdb::FoodGroup.new do |x|
    x.code = data_array[0]
    x.description = data_array[1]
  end

  count += 1
  if count % 2 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::FoodGroup.import data
puts FoodNdb::FoodGroup.count

#############################################################################
module FoodNdb
  class FoodsLangual < ActiveRecord::Base
  end
end
print 'Importing ''foods_languals'' join table'
count = 0
data = []
File.foreach("#{sr_dir}/LANGUAL.txt") do |line|
  data_array = parse_line(line)
  # fix "numbers" that start with '0' so they won't be octal
  data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
  data_array[0] = data_array[0].to_i

  data << FoodNdb::FoodsLangual.new do |x|
    x.nutrient_databank_number = data_array[0]
    x.langual_code = data_array[1]
  end

  count += 1
  if count % 500 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::FoodsLangual.import data
puts FoodNdb::FoodsLangual.count

#############################################################################
print 'Importing ''languals'''
count = 0
data = []
File.foreach("#{sr_dir}/LANGDESC.txt") do |line|
  data_array = parse_line(line)

  data << FoodNdb::Langual.new do |x|
    x.code = data_array[0]
    x.description = data_array[1]
  end

  count += 1
  if count % 20 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::Langual.import data
puts FoodNdb::Langual.count

#############################################################################
print 'Importing ''nutrients'''
count = 0
data = []
File.foreach("#{sr_dir}/NUTR_DEF.txt") do |line|
  data_array = parse_line(line)

  data << FoodNdb::Nutrient.new do |x|
    x.number = data_array[0]
    x.units = data_array[1]
    x.infoods_tagname = data_array[2]
    x.description = data_array[3]
    x.rounded_decimal_places = data_array[4]
    x.sr_sort_order = data_array[5]
  end

  count += 1
  if count % 10 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::Nutrient.import data
puts FoodNdb::Nutrient.count

#############################################################################
# Languals
print 'Importing ''data_sources'''
count = 0
data = []
File.foreach("#{sr_dir}/DATA_SRC.txt") do |line|
  data_array = parse_line(line)

  data << FoodNdb::DataSource.new do |x|
    x.id = data_array[0]
    x.authors = data_array[1]
    x.title = data_array[2]
    x.year = data_array[3]
    x.journal = data_array[4]
    x.volume_or_city = data_array[5]
    x.issue_or_state = data_array[6]
    x.start_page = data_array[7]
    x.end_page = data_array[8]
  end

  count += 1
  if count % 20 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::DataSource.import data
puts FoodNdb::DataSource.count

#############################################################################
module FoodNdb
  class FoodNutrientsDataSources < ActiveRecord::Base
  end
end
print 'Importing ''food_nutrients_data_sources'' join table'
count = 0
data = []
File.foreach("#{sr_dir}/DATSRCLN.txt") do |line|
  data_array = parse_line(line)
  # fix "numbers" that start with '0' so they won't be octal
  data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
  data_array[0] = data_array[0].to_i

  data << FoodNdb::FoodNutrientsDataSources.new do |x|
    x.nutrient_databank_number = data_array[0]
    x.nutrient_number = data_array[1]
    x.data_source_id = data_array[2]
  end

  count += 1
  if count % 2000 == 0
    print '.'
    STDOUT.flush
    FoodNdb::FoodNutrientsDataSources.import data
    data = []
  end
end
FoodNdb::FoodNutrientsDataSources.import data
puts FoodNdb::FoodNutrientsDataSources.count

#############################################################################
print 'Importing ''food_nutrients'''
count = 0
data = []
File.foreach("#{sr_dir}/NUT_DATA.txt") do |line|
  data_array = parse_line(line)
  # fix "numbers" that start with '0' so they won't be octal
  data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
  data_array[0] = data_array[0].to_i

  data << FoodNdb::FoodNutrient.new do |x|
    x.nutrient_databank_number = data_array[0]
    x.nutrient_number = data_array[1]
    x.value = data_array[2]
    x.points_of_data = data_array[3]
    x.standard_error = data_array[4]
    x.source_code = data_array[5]
    x.derivation_code = data_array[6]
    x.reference_nutrient_databank_number = data_array[7]
    x.enriched = data_array[8].to_i
    x.number_of_studies = data_array[9]
    x.min = data_array[10]
    x.max = data_array[11]
    x.degrees_of_freedom = data_array[12]
    x.lower_error_bound = data_array[13]
    x.upper_error_bound = data_array[14]
    x.statistical_comments = data_array[15]
    x.added_or_modified_date = data_array[16]
  end

  count += 1
  if count % 12000 == 0
    print '.'
    STDOUT.flush
    FoodNdb::FoodNutrient.import data
    data = []
  end
end
FoodNdb::FoodNutrient.import data
puts FoodNdb::FoodNutrient.count

#############################################################################
print 'Importing ''sources'''
data = []
File.foreach("#{sr_dir}/SRC_CD.txt") do |line|
  data_array = parse_line(line)

  data << FoodNdb::Source.new do |l|
    l.code = data_array[0]
    l.description = data_array[1]
  end

  print '.'
  STDOUT.flush
end
FoodNdb::Source.import data
puts FoodNdb::Source.count

#############################################################################
print 'Importing ''derivations'''
count = 0
data = []
File.foreach("#{sr_dir}/DERIV_CD.txt") do |line|
  data_array = parse_line(line)

  data << FoodNdb::Derivation.new do |l|
    l.code = data_array[0]
    l.description = data_array[1]
  end

  count += 1
  if count % 2 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::Derivation.import data
puts FoodNdb::Derivation.count

#############################################################################
print 'Importing ''weights'''
count = 0
data = []
File.foreach("#{sr_dir}/WEIGHT.txt") do |line|
  data_array = parse_line(line)
  data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'

  data << FoodNdb::Weight.new do |x|
    x.nutrient_databank_number = data_array[0]
    x.sequence = data_array[1]
    x.amount = data_array[2]
    x.description = data_array[3]
    x.gram_weight = data_array[4]
    x.points_of_data = data_array[5]
    x.standard_deviation = data_array[6]
  end

  count += 1
  if count % 400 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::Weight.import data
puts FoodNdb::Weight.count

############################################################################
print 'Importing ''footnotes'''
count = 0
data = []
File.foreach("#{sr_dir}/FOOTNOTE.txt") do |line|
  data_array = parse_line(line)
  data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'

  data << FoodNdb::Footnote.new do |x|
    x.nutrient_databank_number = data_array[0]
    x.sequence = data_array[1]
    x.the_type = data_array[2]
    x.nutrient_number = data_array[3]
    x.the_text = data_array[4]
  end

  count += 1
  if count % 10 == 0
    print '.'
    STDOUT.flush
  end
end
FoodNdb::Footnote.import data
puts FoodNdb::Footnote.count
