# Run this integration test by typing "rake".
# Note that per Rakefile, these integration test
# filenames must be in path/naming convention
# of "test/test_*.rb"

require_relative 'helper'

class TestCheersIntegration < MiniTest::Unit::TestCase

  def test_a_name_with_no_vowels
    shell_output = ""
    # the from IO.popen... to first "end" is the test
    # simulating the person typing entering "brt"
    # on name = gets.chomp
    IO.popen('ruby program_file.rb', 'r+') do |pipe|
      pipe.puts("brt")
      pipe.close_write
      shell_output = pipe.read
    end
    expected_output = <<EOS
   b
    r
    t
EOS
    #I'm not sure if this should be
    #  .... expected_output, shell_output
    # or vice versa order
    assert_equal expected_output, shell_output
  end
end