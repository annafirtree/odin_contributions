# frozen_string_literal: true

# A linked list, as per the Odin assignment:
# https://www.theodinproject.com/courses/ruby-programming/lessons/linked-lists
class LinkedList
  # Node is an inner class to create a single node
  class Node
    attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end

    def to_s
      @value.to_s
    end
  end

  attr_reader :head

  def initialize(value = nil)
    @head = Node.new(value)
  end

  def append(value)
    node = Node.new(value)
    tail.next_node = node
  end

  def prepend(value)
    node = Node.new(value)
    node.next_node = @head
    @head = node
  end

  def size
    size = 0
    each { size += 1 }
    size
  end

  def tail
    tail = @head
    each { |node| tail = node }
    tail
  end

  def at(index)
    counter = 0
    each do |node|
      return node if counter == index

      counter += 1
    end
    nil
  end

  def pop
    second_to_last_node = at(size - 2) # subtract 2, not 1, b/c of zero-indexing
    second_to_last_node.next_node = nil
  end

  def contains?(value)
    return false if find(value).nil?

    true
  end

  def find(value)
    index = 0
    each do |node|
      return index if node.value == value

      index += 1
    end
    nil
  end

  def to_s
    string = ''
    each do |node|
      string += "(#{node.value}) -> "
    end
    string[0..-4]
  end

  def insert_at(value, index)
    before_node = at(index - 1)
    after_node = at(index)
    new_node = Node.new(value, after_node)
    before_node.next_node = new_node
  end

  def remove_at(index)
    before_node = at(index - 1)
    after_node = at(index + 1)
    before_node.next_node = after_node
  end

  private

  def each
    this_node = @head
    done = false
    until done
      yield(this_node)
      this_node.next_node.nil? ? done = true : this_node = this_node.next_node
    end
  end
end

banana_list = LinkedList.new('a')
banana_list.append('n')
banana_list.prepend('b')
banana_list.append('a')
banana_list.append('ana')
puts banana_list.contains?('ana') # => true
banana_list.pop
puts banana_list.contains?('ana') # => false
banana_list.insert_at('[a]', 3)
puts banana_list.find('[a]')      # => 3
banana_list.insert_at('[n]', 4)
puts banana_list.at(4)            # => [n]
banana_list.append('z')
banana_list.remove_at(banana_list.size - 1)
puts banana_list.size             # => 6
puts banana_list.tail             # => a
puts banana_list.head             # => b
puts banana_list.to_s # => (b) -> (a) -> (n) -> ([a]) -> ([n]) -> (a)
