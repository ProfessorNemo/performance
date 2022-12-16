# frozen_string_literal: true

require 'rspec_api_documentation/dsl'

resource 'Events' do
  Event.destroy_all
  let!(:actual_events) { create_list(:event, 2) }
  let!(:past_event) { create(:event, starts_at: 1.month.ago, ends_at: 7.days.ago) }
  let(:parsed_response_body) { JSON.parse(response_body, symbolize_names: true) }

  explanation 'Events resource'

  header 'Content-Type', 'application/json'

  get '/events' do
    let(:expected_response) { actual_events.map { |s| EventSerializer.new(s) } }

    context '200' do
      example_request 'Getting a list of events' do
        expect(status).to eq(200)
        expect(response_body).to eq(expected_response.to_json)
      end
    end
  end

  delete '/events/:id' do
    context '200' do
      let(:id) { past_event.id }

      example_request 'Deleting an event' do
        expect(status).to eq(200)
        expect(parsed_response_body).to eq({ success: 'ok' })
      end
    end

    context '404' do
      let(:id) { -1 }

      example_request 'Delete - Invalid `id` request' do
        expect(status).to eq(404)
        expect(parsed_response_body).to eq({ errors: 'not found' })
      end
    end
  end

  post '/events', params: { type: :json } do
    with_options scope: :event, with_example: true do
      parameter :title, 'Event title', required: true
      parameter :starts_at, 'Event starts at, DD-MM-YYYY', required: true
      parameter :ends_at, 'Event ends_at, DD-MM-YYYY', required: true
    end

    context '200' do
      let(:title) { 'Бал вампиров' }
      let(:starts_at) { '2023-12-01' }
      let(:ends_at) { '2023-12-15' }

      let(:raw_post) { params.to_json }

      let(:expected_response) do
        {
          title: 'Бал вампиров',
          start_date: '01-12-2023',
          end_date: '15-12-2023'
        }
      end

      example_request 'Create an event' do
        expect(status).to eq(200)
        expect(parsed_response_body.slice(:title, :start_date, :end_date)).to eq(expected_response)
      end
    end

    context '422' do
      let(:title) { '' }
      let(:raw_post) { params.to_json }

      example_request 'Create - Invalid params' do
        expect(status).to eq(422)
        expect(parsed_response_body).to include(:errors)
      end
    end

    context '400' do
      example_request 'Create - Invalid request' do
        expect(status).to eq(400)
        expect(parsed_response_body).to eq({ errors: 'bad request' })
      end
    end
  end
end
