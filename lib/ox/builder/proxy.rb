module Ox::Builder
  class Proxy
    OX_METHODS = %W{
      value eql? attributes [] []= << text nodes alocate locate content root
    }.map(&:to_sym).freeze

    OX_METHODS.each do |method|
      module_eval(<<-EOS)
        def #{method}(*args, &block)
          if node || node.respond_to?(:#{method})
            node.__send__(:#{method}, *args, &block)
          end
        end
      EOS
    end

    # delegate *OX_METHODS, to: :node
    
    attr_reader :node

    def initialize node
      @node = node
    end

    def element *args
      attributes = args.extract_options!
      name = args.shift

      proxify_node(Ox::Element, name) do |proxy|
        proxy.add_attributes(attributes)
        args.each do |text|
          proxy.node << text.to_s if text.respond_to?(:to_s)
        end
        yield proxy if block_given?
        node << proxy.node
      end
    end

    def instruct name, attributes = {}
      proxify_node(Ox::Instruct, name) do |proxy|
        proxy.add_attributes(attributes)
        node << proxy.node
      end
    end

    def cdata content
      proxify_node(Ox::CData, content) do |proxy|
        node << proxy.node
      end
    end

    def comment content
      proxify_node(Ox::Comment, content) do |proxy|
        node << proxy.node
      end
    end

    def add_attributes attributes
      attributes.keys.each do |attribute|
        node[attribute] = attributes[attribute]
      end
    end

    def to_s
      Ox.dump(node)
    end

    protected

    def proxify_node klass, *args, &block
      Proxy.new(klass.new(*args)).tap(&block)
    end
  end
end
