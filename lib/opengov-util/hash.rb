require 'set'

class Hash
  #
  # symbolize_keys!
  #
  unless instance_methods.include? :symbolize_keys!
    def symbolize_keys!
      changed = false
      keys.each do |k|
        next if k.is_a? Symbol
        self[k.to_sym] = delete(k)
        changed = true
      end
      changed ? self : nil
    end
  end

  #
  # select_keys!
  #
  unless instance_methods.include? :select_keys!
    def select_keys!(other, &block)
      unless block_given?
        # type_assert(other, Array, Hash, Set, Regexp)
        if other.is_a? Regexp
          block = ->(k) { k =~ other }
        else
          block = ->(k) { other.include?(k) }
        end
      end
      self.reject! { |key, _val| !block[key] }
    end
  end

  #
  # reject_keys!
  #
  unless instance_methods.include? :reject_keys!
    def reject_keys!(other, &block)
      unless block_given?
        # type_assert(other, Array, Hash, Set, Regexp)
        if other.is_a? Regexp
          block = ->(k) { k =~ other }
        else
          block = ->(k) { other.include?(k) }
        end
      end
      self.reject! { |key, _val| block[key] }
    end
  end

  #
  # symbolize_keys
  #
  unless instance_methods.include? :symbolize_keys
    def symbolize_keys
      new_hsh = dup
      new_hsh.symbolize_keys!
      new_hsh
    end
  end

  #
  # select_keys
  #
  unless instance_methods.include? :select_keys
    def select_keys(other)
      target = dup
      target.select_keys!(other)
      target
    end
  end

  #
  # reject_keys
  #
  unless instance_methods.include? :reject_keys
    def reject_keys(other)
      target = dup
      target.reject_keys!(other)
      target
    end
  end

  #
  # slice
  #
  unless instance_methods.include? :slice
    def slice(*args)
      target = dup
      target.select_keys!(args)
      target
    end
  end

  #
  # Aliases
  #
  unless instance_methods.include? :&
    alias_method :&, :select_keys
  end

  unless instance_methods.include? :-
    alias_method :-, :reject_keys
  end
end