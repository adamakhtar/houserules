class Houserules
  class RulesBuilder
    def initialize(rules)
      @rules = rules
    end

    def call
      table = {}
      footnote_number = 1
      rules.each do |rule|
        resource = rule[:resource]
        action  = rule[:action]
        actor = rule[:actor]
        permitted = rule[:permitted]
        note = rule[:note]

        table[resource] ||= {"actions" => {}, "footnotes" => {}}
        table[resource]["actions"][action] ||= {}
        table[resource]["actions"][action][actor] = {
          'permitted' => permitted,
          'note_number' => nil,
          'note' => ''
        }

        if note.length > 0
          table[resource]["actions"][action][actor]['note'] = note
          table[resource]["actions"][action][actor]['note_number'] = footnote_number
          table[resource]["footnotes"][footnote_number] = note
          footnote_number += 1
        end
      end

      table
    end

    private

    attr_accessor :rules

  end
end