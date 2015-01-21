require File.expand_path('libraries/opsworks_migrations_helper')

describe OpsworksMigrations::Helper do
  modern_attributes = {
      opsworks_migrations: {
          dir: "migrations",
          command: "bundle exec rake db:migrate db:version"
      }
  }
  legacy_attributes = {
      :"opsworks-migrations" => {
          dir: "taco",
          command: "cat"
      }
  }

  let(:helper) { OpsworksMigrations::Helper.new(modern_attributes) }

  it 'should support modern attributes' do
    expect(helper.dir).to eq("migrations")
    expect(helper.command).to eq("bundle exec rake db:migrate db:version")
  end

  describe 'legacy' do
    let(:helper) { OpsworksMigrations::Helper.new(modern_attributes.merge(legacy_attributes)) }

    it 'should support legacy attributes' do
      expect(helper.dir).to eq("taco")
      expect(helper.command).to eq("cat")
    end
  end

end