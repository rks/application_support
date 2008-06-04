require File.dirname(__FILE__) + "/test_helper"
require File.dirname(__FILE__) + "/../lib/array.rb"

class ArrayTest < Test::Unit::TestCase

  def test_should_receive_instance_level_monkey_patches
    injected_methods = %(divided_by)
    injected_methods.each do |method|
      assert Array.new.respond_to?(method.to_sym), "Arrays should respond to #{method}"
    end
  end

  module DividedBy
    class DividedByTest < Test::Unit::TestCase
      def test_divide_by_zero_returns_self
        initial = ["a", "b"]
        assert_equal ["a", "b"], initial.divided_by(0)
      end

      def test_divided_by_one_should_return_self
        initial = ["a", "b"]
        assert_equal ["a", "b"], initial.divided_by(1)
      end

      def test_divides_empty_array
        initial = []
        assert_equal [[], []], initial.divided_by(2)
        assert_equal [[], [], []], initial.divided_by(3)
      end

      def test_divided_by_with_evenly_divisible_array
        initial  = ["a", "b"]
        expected = [["a"], ["b"]]
        assert_equal expected, initial.divided_by(2)
      end

      def test_divided_by_with_non_evenly_divisible_array
        initial  = ["a"]
        expected = [["a"], []]
        assert_equal expected, initial.divided_by(2)
      end

      def test_evenly_divisible_array_divided_by_non_even_divisor
        initial  = ["a", "b", "c"]
        expected = [["a"], ["b"], ["c"]]
        assert_equal expected, initial.divided_by(3)
      end

      def test_non_evenly_divisible_array_divided_by_non_even_divisor
        initial  = ["a", "b"]
        expected = [["a"], ["b"], []]
        assert_equal expected, initial.divided_by(3)
      end

      def test_single_item_array_divided_by_non_even_divisor
        initial  = ["a"]
        expected = [["a"], [], []]
        assert_equal expected, initial.divided_by(3)
      end

      def test_long_array_divided_into_even_groups
        initial  = (1..10).to_a
        expected = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]
        assert_equal expected, initial.divided_by(2)
      end

      def test_long_array_divided_into_non_even_groups
        initial  = (1..10).to_a
        expected = [(1..4).to_a, (5..8).to_a, (9..10).to_a]
        assert_equal expected, initial.divided_by(3)
      end
    end
  end
end