require "houserules/version"
require "houserules/rules_builder"
require "houserules/rules_parser"
require "houserules/html_renderer"
require "rspec/core"

class Houserules

  class << self
    attr_accessor :rules
  end

  @rules = []

  def self.parse(rule_description)
    parser = RulesParser.new
    rule = parser.call(rule_description)
    self.rules << rule
  end

  def self.render(template_path)
    builder = RulesBuilder.new(self.rules)
    rules_table = builder.call
    renderer = HtmlRenderer.new(rules_table)
    html = renderer.call(template_path: template_path)
  end

  def self.clear
    self.rules = []
  end
end

RSpec.configure do |config|
  config.around(:example) do |example|
    if example.metadata.fetch(:houserule, false)
      Houserules.parse(example.metadata[:full_description])
    end

    example.run
  end
end