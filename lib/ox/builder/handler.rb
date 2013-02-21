module Ox::Builder
  class Handler
    class_attribute :default_format
    self.default_format = Mime::XML

    def call template
      <<-SOURCE
      (
        Ox::Builder.document do |xml|
          #{template.source}
        end
      ).to_s;
      SOURCE
    end
  end
end

ActionView::Template.register_template_handler :ox, Ox::Builder::Handler.new if defined?(ActionView)
