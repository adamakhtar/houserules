RSpec.describe Houserules::HtmlRenderer do
  it "renders rules table into html" do
    rules_table = {
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
        }
      }
    }
    renderer = Houserules::HtmlRenderer.new(rules_table)
    template_path = Pathname.new(__FILE__).join("../../fixtures/template.html.erb")

    html = renderer.call(template_path: template_path)

    expect(html).to include "<table>"
    expect(html).to include "<h2>Posts</h2>"
    expect(html).to include "<th>admin</th>"
    expect(html).to include "<th>guest</th>"
    expect(html).to include "<td>creating a post</td>"
  end
end


