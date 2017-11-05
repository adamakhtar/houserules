module Houserules
  class HtmlRenderer
    def initialize(rules_table)
      @rules = rules_table
    end

    def call(template_path)
      template = File.read( Rails.root.join(template_path)
      html = ERB.new(template).result(binding)
    end
  end
end