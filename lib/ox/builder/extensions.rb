unless defined?(ActiveSupport)
  class Hash
    def extractable_options?
      instance_of?(Hash)
    end

    def stringify_keys
      dup.stringify_keys!
    end

    def stringify_keys!
      keys.each do |key|
        self[key.to_s] = delete(key)
      end
      self
    end
  end

  class Array
    def extract_options!
      if last.is_a?(Hash) && last.extractable_options?
        pop
      else
        {}
      end
    end
  end
end
