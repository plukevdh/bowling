require 'forwardable.rb'

# Simple linked list implementation
# Not a pure or complete solution. Simply what I needed
#
class LinkedList
  extend Forwardable

  class EmptyListError < StandardError ; end

  class Node
    attr_reader :value
    attr_accessor :next

    def initialize(item)
      @next = nil
      @value = item
    end

    def next?
      !@next.nil?
    end

    # delegate methods to the data object
    def method_missing(method, *args, &block)
      return @value.send(method, *args, &block) if @value.respond_to?(method)
      super
    end
  end

  ROOT_NODE = Node.new(nil)

  def self.create_from_items(items)
    list = new
    items.each {|item| list.insert(item) }
    list
  end

  def self.create_from_nodes(nodes)
    list = new
    nodes.each {|node| list.insert_node(node) }
    list
  end

  def initialize
    @list = []
  end

  def first_node
    return ROOT_NODE if @list.empty?
    @list.first
  end

  def last_node
    @list.last || ROOT_NODE
  end

  def insert(item)
    parent = last_node
    new_node = Node.new(item)

    @list.push new_node
    parent.next = new_node
  end

  def insert_node(node)
    parent = @list.last || ROOT_NODE
    @list.push(node)
    parent.next = node
  end

  def sublist(index)
    LinkedList.create_from_nodes @list[0..index-1]
  end

  def_delegators :@list, :length, :count, :size, :each, :reduce
end