# example of a file defining a class
require 'date'

class DateParser
  def self.parse(date_string)
    dateHash = Hash.new

    dateHash["month"] = /\A\d+/.match(date_string).to_s.to_i
    remainder_string = /\A\d+/.match(date_string).post_match.to_s
    dateHash["day"] = /\d+/.match(remainder_string).to_s.to_i
    remainder_string = /\d+/.match(remainder_string).post_match.to_s
    dateHash["year"] = self.calc_year(remainder_string)

    dateHash
  end

  # reminder class vs. instance methods
  # http://www.railstips.org/blog/archives/2009/05/11/class-and-instance-methods-in-ruby/
  def self.calc_year(remainder_string)
    year = /\d+/.match(remainder_string).to_s.to_i

    if year.to_s.length == 2
      current_even_centuries = (Time.now.year / 100) * 100
      current_two_digit_year = Time.now.year - current_even_centuries
      if year <= current_two_digit_year
        year += current_even_centuries
      else
        previous_century = current_even_centuries - 100
        year += previous_century
      end
    end

    year
  end
end