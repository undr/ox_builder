require 'ox/builder/proxy'

module Ox::Builder
  extend self

  def document attributes = {}, options = {}
    attributes = default_attributes.merge(attributes.stringify_keys)
    Proxy.new(Ox::Document.new(attributes)).tap do |doc|
      doc.instruct('xml', attributes)
      yield doc if block_given?
    end
  end

  private
  def default_attributes
    {'version' => '1.0', 'encoding' => 'UTF-8'}
  end
end
