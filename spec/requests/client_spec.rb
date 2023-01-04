# frozen_string_literal: true

RSpec.describe Exchange::Client do
  let(:test_client) { described_class.new(ENV.fetch('TOKEN', 'fake')) }

  specify '#performances' do
    # JSON.dump - чтобы получить строку на основе хэша
    body = JSON.dump([
                       {
                         'id' => '3',
                         'title' => 'Бал вампиров',
                         'start_date' => '14-02-2023',
                         'end_date' => '14-03-2023'
                       },
                       {
                         'id' => '4',
                         'title' => 'Демон Онегина',
                         'start_date' => '15-03-2023',
                         'end_date' => '31-03-2023'
                       }
                     ])

    stub_request(:get, 'http://127.0.0.1:3000/events')
      .with(
        headers: {
          'token' => test_client.token
        }
      )
      .to_return(status: 200, body: body, headers: {})

    performance = test_client.performances

    expect(performance.pluck('title')).to eq(['Бал вампиров', 'Демон Онегина'])
    expect(WebMock).to have_requested(
      :get, 'http://127.0.0.1:3000/events'
    ).once
  end

  describe '#create_performance' do
    it 'creates performance with proper params' do
      body = JSON.dump({ title: 'Ромео и Джульетта', start_date: '2025-06-01', end_date: '2025-07-01' })

      stub_request(:post, 'http://127.0.0.1:3000/events')
        .with(
          headers: {
            token: test_client.token
          }
        )
        .to_return(status: 200, body: body, headers: { content_type: 'application/json' })

      performance = test_client.create_performance title: 'Ромео и Джульетта', start_date: '2025-06-01',
                                                   end_date: '2025-07-01'
      expect(performance['title']).to eq('Ромео и Джульетта')
    end

    it 'raises an error with invalid params' do
      stub_request(:post, 'http://127.0.0.1:3000/events')
        .to_raise(StandardError)

      expect { test_client.create_performance({}) }.to raise_error(StandardError)
    end
  end
end
