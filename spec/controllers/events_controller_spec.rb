# frozen_string_literal: true

RSpec.describe EventsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:event_params) { attributes_for(:event) }

      it do
        post :create, params: { event: event_params }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:event_params) { { title: '' } }

      it do
        post :create, params: { event: event_params }
        expect(response).to have_http_status('422')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:event) { create(:event) }
    subject { -> { delete :destroy, params: { id: event_id } } }

    context 'with valid id' do
      let(:event_id) { event.id }

      it { is_expected.to change(Event, :count).by(-1) }
    end

    context 'with invalid id' do
      let(:event_id) { -1 }

      it { is_expected.not_to change(Event, :count) }
    end
  end
end
