# frozen_string_literal: true

RSpec.describe Box::ApiJson do
  let(:path) { 'http://127.0.0.1:3000/events' }

  let(:events) do
    VCR.use_cassette('events') { described_class.call(path) }
  end

  let(:event) { events.sample }

  it 'can fetch & parse event data' do
    expect(events).to be_a(Array)

    expect(events.map { |i| i.instance_of?(Hash) ? true : nil }.uniq.join).to eq('true')

    expect(event).to be_a(Hash)

    expect(event).to respond_to(:keys)

    expect(event).to have_key(:title)

    expect(event.any?(String)).not_to be_a(String)

    expect(event.keys).to contain_exactly(:id, :title, :start_date, :end_date)

    puts events.inspect
  end
end
