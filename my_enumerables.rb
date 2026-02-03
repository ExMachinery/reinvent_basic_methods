module Enumerable
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    counter = 0
    self.my_each do |elem|
        yield(elem, counter)
        counter += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    self.my_each {|elem| result << elem if yield(elem)}
    result
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    result = true
    self.my_each do |elem|
      if !yield(elem)
        result = false
        break
      end
    end
    result
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    result = false
    self.my_each do |elem|
      if yield(elem)
        result = true
        break
      end
    end
    result
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    result = true
    self.my_each do |elem|
      if yield(elem)
        result = false
        break
      end
    end
    result
  end

  def my_count
    return self.size unless block_given?

    counter = 0
    self.my_each {|elem| counter += 1 if yield(elem)}
    counter
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    result = []
    self.my_each {|elem| result << yield(elem)}
    result
  end

  def my_inject(initial_value)
    return to_enum(:my_inject) unless block_given?

    initial_value ? accumulator = initial_value : accumulator = self[0]
    start_from = 0
    start_from = 1 if initial_value == nil
    self[start_from..].my_each do |elem| 
        accumulator = yield(accumulator, elem)
    end
    accumulator
  end
end


class Array
  def my_each
    return to_enum(:my_each) unless block_given?

    counter = 0
    until counter == self.size
      yield(self[counter])
      counter += 1
    end
    self
  end
end
