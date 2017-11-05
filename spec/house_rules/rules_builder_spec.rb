RSpec.describe Houserules::RulesBuilder do
  it "generates rules table" do
    rule_a = {
      resource: 'Posts',
      action: 'creating a post',
      permitted: true,
      actor: 'admin',
      note: 'email is confirmed'
    }
    rule_b = {
      resource: 'Posts',
      action: 'creating a post',
      permitted: false,
      actor: 'guest',
      note: ''
    }
    builder = Houserules::RulesBuilder.new([rule_a, rule_b])

    table = builder.call

    expected_result = {
      'Posts' => {
        'actions' => {
          'creating a post' => {
            'admin' => {
              'permitted' => true,
              'note' => 'email is confirmed',
              'note_number' => 1
            },
            'guest' => {
              'permitted' => false,
              'note' => '',
              'note_number' => nil
            }
          }
        },
        'footnotes' => {
          1 => 'email is confirmed'
        }
      }
    }
    expect(table).to eq expected_result
  end
end
