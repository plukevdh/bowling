require 'minitest/autorun'
require_relative "linked_list"

class TestLinkedList < MiniTest::Unit::TestCase
  def setup
    @list = LinkedList.new
  end

  def test_initially_empty
    assert_equal 0, @list.length
  end

  def test_add_array_of_items
    new_list = LinkedList.create_from_items([1,2,3,4,5,6,7])
    assert_equal 7, new_list.size
    assert_kind_of LinkedList::Node, new_list.first_node
    assert_equal 1, new_list.first_node.value
  end

  def test_root_node_when_first_node_on_empty_list
    assert_equal LinkedList::ROOT_NODE, @list.first_node
  end

  def test_can_add_items
    @list.insert(1)
    @list.insert(5)

    assert_equal 2, @list.size
    assert_equal LinkedList::Node, @list.first_node.class
  end

  def test_can_add_node
    @list.insert(1)
    @list.insert_node(LinkedList::Node.new(5))

    assert_equal 2, @list.size
    assert_equal 5, @list.first_node.next.value
  end

  def test_can_traverse_list
    @list.insert(1)
    @list.insert(5)
    @list.insert(10)
    @list.insert(4)

    senteniel = @list.first_node
    assert_equal 1, senteniel.value

    senteniel = senteniel.next.next
    assert_equal 10, senteniel.value
  end

  def test_delegates_methods_to_value
    @list.insert(10)
    result = @list.first_node / 2

    assert_equal 5, result

    assert_raises NoMethodError do
      @list.first_node.whatever
    end
  end

  def test_can_get_list_subset
    @list.insert(1)
    @list.insert(5)
    @list.insert(22)
    @list.insert(5)

    first_three = @list.sublist(3)
    assert_kind_of LinkedList, first_three
    assert_equal 3, first_three.size
    assert_equal 22, first_three.first_node.next.next.value
  end
end