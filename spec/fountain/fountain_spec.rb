# frozen_string_literal: true

require 'spec_helper'

describe Fountain do
  describe Fountain::Error do
    it { is_expected.to be_a StandardError }
  end

  describe Fountain::HTTPError do
    it { is_expected.to be_a Fountain::Error }
  end

  describe Fountain::NotFoundError do
    it { is_expected.to be_a Fountain::HTTPError }
  end

  describe Fountain::AuthenticationError do
    it { is_expected.to be_a Fountain::HTTPError }
  end

  describe Fountain::InvalidMethodError do
    it { is_expected.to be_a Fountain::HTTPError }
  end

  describe Fountain::UnexpectedHTTPError do
    subject(:unexpected_http_error) { described_class.new(response) }

    let(:response) do
      Net::HTTPUnprocessableEntity.new('1.1', '422', 'Unprocessable Entity').tap do |r|
        r.body = response_body
        r.instance_variable_set :@read, true
      end
    end
    let(:response_body) { '{"message": "Applicant is already on this stage"}' }

    it { is_expected.to be_a Fountain::HTTPError }

    describe '#response_code' do
      subject(:response_code) { unexpected_http_error.response_code }

      it { is_expected.to eq '422' }
    end

    describe '#parsed_body' do
      subject(:parsed_body) { unexpected_http_error.parsed_body }

      it { is_expected.to eq('message' => 'Applicant is already on this stage') }

      context 'when the response body is not JSON' do
        let(:response_body) { 'This isnt JSON' }

        it { is_expected.to eq 'This isnt JSON' }
      end
    end

    describe '#response_message' do
      subject(:response_message) { unexpected_http_error.response_message }

      it { is_expected.to eq 'Applicant is already on this stage' }

      context 'when the response body is not JSON' do
        let(:response_body) { 'This isnt JSON' }

        it { is_expected.to be_nil }
      end
    end
  end

  describe Fountain::JsonParseError do
    it { is_expected.to be_a Fountain::Error }
  end

  describe Fountain::MissingApiKeyError do
    it { is_expected.to be_a Fountain::Error }
  end

  describe Fountain::StatusError do
    it { is_expected.to be_a Fountain::Error }
  end
end
