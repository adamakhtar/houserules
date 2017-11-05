module Houserules
  class RulesParser
    def initialize
    end

    def call(description)
      matches = description.match /\A(?<resource>.*?)when(?<action>.*?)(?<permission>permits|denies)(?<actor>.+?)(?<note>\(.*?\))?\Z/
      resource = matches[:resource].strip
      resource = resource.gsub(/[:-]/, "").strip
      actor = matches[:actor].strip
      action = matches[:action].strip
      action = action.gsub(/ it\Z/, "")
      permission = matches[:permission].strip
      permitted = permission == 'permits' ? true : false
      note = matches[:note] ? matches[:note].gsub(/[()]/, "") : ''

      {
        resource: resource,
        actor: actor,
        action: action,
        permitted: permitted,
        note: note
      }
    end
  end
end