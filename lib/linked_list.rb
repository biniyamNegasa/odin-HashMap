# frozen_string_literal: true

# A linked list node
class Node
  attr_accessor :key, :val, :prev, :next

  def initialize(key, val, prev = nil, nxt = nil)
    @key = key
    @val = val
    @prev = prev
    @next = nxt
  end
end

# linked list
class LinkedList
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(key, val)
    node = Node.new(key, val)
    @size += 1
    if @tail.nil?
      @tail = node
      @head = node
    else
      node.prev = @tail
      @tail.next = node
      @tail = @tail.next
    end
  end

  attr_reader :size, :head, :tail

  def pop
    return if @tail.nil?

    @size -= 1
    popped = @tail
    @tail = @tail.prev
    if size.zero?
      @head = nil
    else
      @tail.next = nil
    end
    popped.prev = nil
    popped
  end

  def contains?(key)
    current = @head
    until current.nil?
      return true if current.key == key

      current = current.next
    end
    false
  end

  def find(key)
    current = @head
    index = 0
    until current.nil?
      return current if current.key == key

      current = current.next
      index += 1
    end
    nil
  end

  def remove(key)
    node = find(key)
    return if node.nil?

    @size -= 1
    if node.prev.nil? && node.next.nil?
      @head = nil
      @tail = nil
    elsif node.prev.nil?
      @head = @head.next
      @head.prev = nil
    elsif node.next.nil?
      @tail = @tail.prev
      @tail.next = nil
    else
      previous = node.prev
      nxt = node.next
      previous.next = nxt
      nxt.prev = previous
      node.next = nil
      node.prev = nil
    end
    node.val
  end

  def to_s
    current = @head
    array = []
    until current.nil?
      array << "( #{current.key}: #{current.val} ) -> "
      current = current.next
    end
    array << 'nil'
    array.join
  end
end
