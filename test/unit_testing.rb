# Run this unit test file by typing "ruby test/this_file_name.rb"

# name of the class file being tested
require File.expand_path("./a_class_file.rb")
require 'minitest/autorun'
require_relative 'helper'

class TestDateParser < MiniTest::Unit::TestCase

=begin
  start with parsing a normal date format of mm/DD/YY
  into local dateHash as Fixnum under keys month, day, and year
  for 1-2 month or day, and 2 xor 4 digit year
=end

  def test_1_date_parser_has_a_parse_method
    DateParser.parse("12/22/2012")
  end

  def test_2_MMddYYYY_returns_2_digit_month
    assert_equal 12, (DateParser.parse("12/22/2012"))["month"]
  end

  def test_2b_MMddYYYY_returns_leading_zero_month_as_1_digit
    assert_equal 2, (DateParser.parse("02/10/2012"))["month"]
  end

  def test_3_MMddYYYY_returns_2_digit_day_as_2_digits
    assert_equal 22, (DateParser.parse("12/22/2012"))["day"]
  end

  def test_3b_MMddYYY_returns_2_digit_day_leading_zero_as_1_digit
    assert_equal 2, (DateParser.parse("12/02/2012"))["day"]
  end

  def test_4_MMddYYYY_returns_4_digit_year
    assert_equal 2012,  (DateParser.parse("12/22/2012"))["year"]
  end

# =begin
#   Next write tests for normal format month/day/year
#   that can handle 1 digit month, 1 digit day, and 2 digit year
# =end

  def test_5_MddYYYY_returns_1_digit_month
    assert_equal 1, (DateParser.parse("1/22/2012"))["month"]
  end

  def test_6_monthDyyyy_returns_1_digit_day
    assert_equal 2, (DateParser.parse("1/2/2012"))["day"]
  end

  def test_7_monthDayYY_returns_2_digit_year_as_4_digits
    assert_equal 1995, (DateParser.parse("1/2/95"))["year"]
    assert_equal 2013, (DateParser.parse("1/2/2013"))["year"]
  end

  def test_8_MonthDayYear_combinations_of_digits
    # assert_equal [1, 2, 1950], DateParser.parse("1/2/50").values
    assert_equal [1, 2, 1950], results_array("1/2/50")
    assert_equal [1, 2, 1950], results_array("1/2/1950")
    assert_equal [1, 2, 1950], results_array("01/2/50")
    assert_equal [11, 2, 1950], results_array("11/2/50")
    assert_equal [1, 2, 1950], results_array("01/2/1950")
    assert_equal [11, 2, 1950], results_array("11/2/1950")
    assert_equal [1, 2, 1950], results_array("1/02/50")
    assert_equal [1, 20, 1950], results_array("1/20/1950")
    assert_equal [1, 2, 1950], results_array("01/02/1950")
    assert_equal [11, 2, 1950], results_array("11/02/1950")
    assert_equal [1, 2, 1950], results_array("01/02/1950")
    assert_equal [11, 2, 1950], results_array("11/02/1950")
  end

  def test_9_leading_whitespace_not_affect_date
    assert_equal [1, 2, 1950], results_array("   1/2/50")
  end

  def test_10_trailing_whitespace_not_affect_date
    assert_equal [1, 2, 1950], results_array("1/2/50   ")
  end

  def test_11_whitespace_inside_not_affect_date
    assert_equal [1, 2, 1950], results_array("1/  2/50")
    assert_equal [1, 22, 1950], results_array("1/ 2 2 / 50")
    assert_equal [1, 22, 1950], results_array(" 1  / 2 2 / 5 0 ")
  end

  def test_12_extract_time_string
    assert_equal [1, 2, 1950, "10:00"], results_array("1/2/1950 10:00")
    assert_equal [1, 2, 1950, "10:00"], results_array("10:00   1/2/1950")
    assert_equal [1, 2, 1950, "10:00PM"], results_array("10:00PM 1/2/1950")
  end

  def test_13_time_return_24hr_hours
    assert_equal [1, 2, 1950, "10:00PM", 22], results_array("1/2/1950 10:00PM")
    assert_equal [1, 2, 1950, "3:00AM", 3], results_array("1/2/1950 3:00AM")
  end

  def test_14_time_return_12hr_hours
    assert_equal [1, 2, 1950, "10:00PM", 22, 10], results_array("1/2/1950 10:00PM")
    assert_equal [1, 2, 1950, "3:00AM", 3, 3], results_array("1/2/1950 3:00AM")
  end

  def test_15_time_return_AM_PM
    assert_equal [1, 2, 1950, "10:00PM", 22, "PM"], results_array("1/2/1950 10:00PM")
    assert_equal [1, 2, 1950, "3:00AM", 3, "AM"], results_array("1/2/1950 3:00AM")
  end

  def test_16_time_return_minute
    assert_equal [1, 2, 1950, "10:25PM", 22, "PM", 25], results_array("1/2/1950 10:25PM")
    assert_equal [1, 2, 1950, "3:42AM", 3, "AM",  42], results_array("1/2/1950 3:42AM")
  end

  def results_array(date_string)
    DateParser.parse(date_string).values
  end

=begin
  look up standard format for month/day/year with time
  and determine how to start parsing also time starting with hours only
=end
end