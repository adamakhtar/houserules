class Houserules
  class HtmlRenderer
    def initialize(rules_table)
      @rules = rules_table
    end

    def call(template_path: nil, template_html: nil)
      if template_path
        template_html = File.read(template_path)
      end

      html = ERB.new(template_html).result(binding)
    end
  end
end