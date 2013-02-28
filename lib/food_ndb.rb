require "food_ndb/engine"
require 'activerecord-import'

module FoodNdb
  class FoodsLangual < ActiveRecord::Base
  end
  class FoodNutrientsDataSources < ActiveRecord::Base
  end

  def self.parse_line(line)
    line.encode!('UTF-8', 'UTF-8', :invalid => :replace)
    data_array = []
    line.split('^').each do |data|
      item = data.chomp().chomp('~').reverse().chomp().chomp('~').reverse().chomp
      data_array << item
    end
    data_array
  end

  def self.seed_db(sr_dir)
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

      data << Food.new do |x|
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
    Food.import data
    puts Food.count

    #############################################################################
    print 'Importing ''food groups'''
    count = 0
    data = []
    File.foreach("#{sr_dir}/FD_GROUP.txt") do |line|
      data_array = parse_line(line)
      # fix "numbers" that start with '0' so they won't be octal
      data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
      data_array[0] = data_array[0].to_i

      data << FoodGroup.new do |x|
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
    puts FoodGroup.count

    #############################################################################
    print 'Importing ''foods_languals'' join table'
    count = 0
    data = []
    File.foreach("#{sr_dir}/sr#{SR_VER}/LANGUAL.txt") do |line|
      data_array = parse_line(line)
      # fix "numbers" that start with '0' so they won't be octal
      data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
      data_array[0] = data_array[0].to_i

      data << FoodsLangual.new do |x|
        x.nutrient_databank_number = data_array[0]
        x.langual_code = data_array[1]
      end

      count += 1
      if count % 500 == 0
        print '.'
        STDOUT.flush
      end
    end
    FoodsLangual.import data
    puts FoodsLangual.count

    #############################################################################
    print 'Importing ''languals'''
    count = 0
    data = []
    File.foreach("#{sr_dir}/LANGDESC.txt") do |line|
      data_array = parse_line(line)

      data << Langual.new do |x|
        x.code = data_array[0]
        x.description = data_array[1]
      end

      count += 1
      if count % 20 == 0
        print '.'
        STDOUT.flush
      end
    end
    Langual.import data
    puts Langual.count

    #############################################################################
    print 'Importing ''nutrients'''
    count = 0
    data = []
    File.foreach("#{sr_dir}/NUTR_DEF.txt") do |line|
      data_array = parse_line(line)

      data << Nutrient.new do |x|
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
    Nutrient.import data
    puts Nutrient.count

    #############################################################################
    print 'Importing ''data_sources'''
    count = 0
    data = []
    File.foreach("#{sr_dir}/DATA_SRC.txt") do |line|
      data_array = parse_line(line)

      data << DataSource.new do |x|
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
    DataSource.import data
    puts DataSource.count

    #############################################################################
    print 'Importing ''food_nutrients_data_sources'' join table'
    count = 0
    data = []
    File.foreach("#{sr_dir}/DATSRCLN.txt") do |line|
      data_array = parse_line(line)
      # fix "numbers" that start with '0' so they won't be octal
      data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'
      data_array[0] = data_array[0].to_i

      data << FoodNutrientsDataSources.new do |x|
        x.nutrient_databank_number = data_array[0]
        x.nutrient_number = data_array[1]
        x.data_source_id = data_array[2]
      end

      count += 1
      if count % 2000 == 0
        print '.'
        STDOUT.flush
      end
    end
    FoodNutrientsDataSources.import data
    puts FoodNutrientsDataSources.count

    #############################################################################
    print 'Importing ''sources'''
    data = []
    File.foreach("#{sr_dir}/SRC_CD.txt") do |line|
      data_array = parse_line(line)

      data << Source.new do |l|
        l.code = data_array[0]
        l.description = data_array[1]
      end

      print '.'
      STDOUT.flush
    end
    Source.import data
    puts Source.count

    #############################################################################
    print 'Importing ''derivations'''
    count = 0
    data = []
    File.foreach("#{sr_dir}/DERIV_CD.txt") do |line|
      data_array = parse_line(line)

      data << Derivation.new do |l|
        l.code = data_array[0]
        l.description = data_array[1]
      end

      count += 1
      if count % 2 == 0
        print '.'
        STDOUT.flush
      end
    end
    Derivation.import data
    puts Derivation.count

    #############################################################################
    print 'Importing ''weights'''
    count = 0
    data = []
    File.foreach("#{sr_dir}/WEIGHT.txt") do |line|
      data_array = parse_line(line)
      data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'

      data << Weight.new do |x|
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
    Weight.import data
    puts Weight.count

    ############################################################################
    print 'Importing ''footnotes'''
    count = 0
    data = []
    File.foreach("#{sr_dir}/FOOTNOTE.txt") do |line|
      data_array = parse_line(line)
      data_array[0] = data_array[0][1..-1] if data_array[0][0] == '0'

      data << Footnote.new do |x|
        x.nutrient_databank_number = data_array[0]
        x.sequence = data_array[1]
        x.type = data_array[2]
        x.nutrient_number = data_array[3]
        x.text = data_array[4]
      end

      count += 1
      if count % 10 == 0
        print '.'
        STDOUT.flush
      end
    end
    Footnote.import data
    puts Footnote.count
  end
end

