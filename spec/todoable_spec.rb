require 'spec_helper'

RSpec.describe Todoable do
  it 'has a version number' do
    expect(Todoable::VERSION).not_to be nil
  end

  describe Todoable::Client do
    # Make private methods public for testing
    before(:each) do
      Todoable::Client.send(:public, *Todoable::Client.private_instance_methods)
    end

    describe '#initialize' do
      context 'no credentials' do
        before do
          ENV['TODOABLE_USERNAME'] = nil
          ENV['TODOABLE_PASSWORD'] = nil
        end
        it 'throws an exception' do
          expect { Todoable::Client.new }.to raise_error(ArgumentError)
        end
      end

      context 'credentials from environment' do
        before do
          ENV['TODOABLE_USERNAME'] = 'user'
          ENV['TODOABLE_PASSWORD'] = 'pass'
        end
        it 'creates a new client without an error' do
          Todoable::Client.new
        end
      end

      context 'credentials passed directly' do
        it 'creates a new client without an error' do
          Todoable::Client.new(username: 'user', password: 'pass')
        end
      end
    end

    describe '#token_invalid?' do
      let(:client) { Todoable::Client.new(username: 'user', password: 'pass') }

      context 'nil token' do
        before do
          client.instance_variable_set(:@token, nil)
        end
        it 'should return true' do
          expect(client.token_invalid?).to be true
        end
      end

      context 'token expired' do
        let(:yesterday) { Time.now.utc - 60 * 60 * 24 }

        before do
          client.instance_variable_set(:@token,
                                       'token' => 12_345,
                                       'expires_at' => yesterday.to_s)
        end

        it 'should return true' do
          expect(client.token_invalid?).to be true
        end

        context 'valid token' do
          let(:tomorrow) { Time.now.utc + 60 * 60 * 24 }

          before do
            client.instance_variable_set(:@token,
                                         'token' => 12_345,
                                         'expires_at' => tomorrow.to_s)
          end

          it 'should return false' do
            expect(client.token_invalid?).to be false
          end
        end
      end
    end
  end
end
