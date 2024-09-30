# frozen_string_literal: true

require_relative 'linked_list'

# Hash map implementation
class HashMap
  attr_reader :length

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @hashmap = [LinkedList.new] * @capacity
    @length = 0
  end

  def set(key, value)
    double if @capacity * @load_factor <= length

    index = hash(key) % capacity
    node = @hashmap[index].find(key)
    if node.nil?
      @hashmap[index].append(key, value)
    else
      node.val = value
    end
  end

  def get(key)
    index = hash(key) % capacity
    node = @hashmap[index].find(key)
    return if node.nil?

    node.val
  end

  def has?(key)
    index = hash(key) % capacity
    @hashmap[index].contains?(key)
  end

  def remove(key)
    index = hash(key) % capacity
    @hashmap[index].remove(key)
  end

  def clear
    @length = 0
    @capacity = 16
    @hashmap = [LinkedList.new] * @capacity
  end

  def keys
    keys_array = []
    @hashmap.each do |node|
      current = node
      until current.nil?
        keys_array.append(current.key)
        current = current.next
      end
    end
    keys_array
  end

  def values
    values_array = []
    @hashmap.each do |node|
      current = node
      until current.nil?
        values_array.append(current.val)
        current = current.next
      end
    end
    values_array
  end

  def entries
    array = []
    @hashmap.each do |node|
      current = node
      until current.nil?
        array.append([current.key, current.val])
        current = current.next
      end
    end
    array
  end

  private

  def double
    @capacity *= 2
    temp_array = [LinkedList.new] * @capacity
    @hashmap.each do |node|
      current = node
      until current.nil?
        index = hash(current.key)
        temp_array[index].append(current.key, current.value)
        current = current.next
      end
    end
    @hashmap = temp_array
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end
