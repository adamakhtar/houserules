module Houserules
  class RulesParser
    def initialize
    end

    def call(description)
      matches = description.match /(?<resource>.*?)when(?<action>.*?)(?<permission>permits|denies)(?<actor>.+)/
      resource = matches[:resource].strip
      resource = resource.gsub(/[:-]/, "").strip
      actor = matches[:actor].strip
      action = matches[:action].strip
      action = action.gsub(/ it\Z/, "")
      permission = matches[:permission].strip
      permitted = permission == 'permits' ? true : false

      {
        resource: resource,
        actor: actor,
        action: action,
        permitted: permitted
      }
    end
  end
end