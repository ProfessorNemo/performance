# frozen_string_literal: true

RSpec.describe Event do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :starts_at }
  it { is_expected.to validate_presence_of :ends_at }

  describe 'validations check' do
    describe 'dates order check' do
      context 'when ends_at  >= starts_at' do
        subject { build(:event, starts_at: '2023-05-01', ends_at: '2023-05-01') }

        it { is_expected.to be_valid }
      end

      context 'when ends_at < starts_at' do
        subject { build(:event, starts_at: '2023-05-02', ends_at: '2023-05-01') }

        it { is_expected.not_to be_valid }
      end
    end

    describe 'dates overlapping check' do
      before { create(:event, starts_at: '2023-05-01', ends_at: '2023-05-07') }

      context 'when new event overlaps at start' do
        subject { build(:event, starts_at: '2023-04-30', ends_at: '2023-05-02') }

        it { is_expected.not_to be_valid }
      end

      context 'when new event overlaps at end' do
        subject { build(:event, starts_at: '2023-05-06', ends_at: '2023-05-13') }

        it { is_expected.not_to be_valid }
      end

      context 'when new event inside period' do
        subject { build(:event, starts_at: '2023-05-03', ends_at: '2023-05-04') }

        it { is_expected.not_to be_valid }
      end

      context 'when new event overlaps whole period' do
        subject { build(:event, starts_at: '2023-04-03', ends_at: '2023-05-04') }

        it { is_expected.not_to be_valid }
      end

      context 'when new event before existing' do
        subject { build(:event, starts_at: '2023-04-03', ends_at: '2023-04-30') }

        it { is_expected.to be_valid }
      end

      context 'when new event after existing' do
        subject { build(:event, starts_at: '2028-05-08', ends_at: '2028-05-15') }

        it { is_expected.to be_valid }
      end
    end
  end
end
