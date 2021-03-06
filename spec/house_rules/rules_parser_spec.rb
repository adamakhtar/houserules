RSpec.describe Houserules::RulesParser do
  it "parses permitted " do
    parser = Houserules::RulesParser.new

    result = parser.call("Job Applicants: when creating an applicant it permits super admin (email must be confirmed)")

    expect(result[:resource]).to eq "Job Applicants"
    expect(result[:actor]).to eq "super admin"
    expect(result[:action]).to eq "creating an applicant"
    expect(result[:permitted]).to eq true
    expect(result[:note]).to eq 'email must be confirmed'
  end

  it "parses denied " do
    parser = Houserules::RulesParser.new

    result = parser.call("Posts: when creating a post it denies guest")

    expect(result[:resource]).to eq "Posts"
    expect(result[:actor]).to eq "guest"
    expect(result[:action]).to eq "creating a post"
    expect(result[:permitted]).to eq false
    expect(result[:note]).to eq ''
  end
end


