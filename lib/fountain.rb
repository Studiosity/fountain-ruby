# frozen_string_literal: true

require 'fountain/gem_version'

require 'json'
require 'forwardable'

require 'fountain/configuration'
require 'fountain/util'

module Fountain
  class Error < StandardError; end

  class HTTPError < Error; end

  class NotFoundError < HTTPError; end

  class AuthenticationError < HTTPError; end

  class InvalidMethodError < HTTPError; end

  #
  # Unexpected HTTP Error
  #
  class UnexpectedHTTPError < HTTPError
    def initialize(response)
      @response = response
      super("Unexpected http response code: #{response.code}")
    end

    def response_code
      @response.code
    end

    def parsed_body
      JSON.parse(@response.body)
    rescue JSON::ParserError
      @response.body
    end

    def response_message
      body = parsed_body
      body['message'] if body.is_a? Hash
    end
  end

  class JsonParseError < Error; end

  class MissingApiKeyError < Error; end

  class StatusError < Error; end
end

require 'fountain/applicant'
require 'fountain/applicants'
require 'fountain/background_check'
require 'fountain/document_signature'
require 'fountain/field'
require 'fountain/funnel'
require 'fountain/funnels'
require 'fountain/label'
require 'fountain/location'
require 'fountain/note'
require 'fountain/secure_document'
require 'fountain/slot'
require 'fountain/slots'
require 'fountain/stage'
require 'fountain/transition'
require 'fountain/user'

require 'fountain/api/request_helper'
require 'fountain/api/applicants'
require 'fountain/api/available_slots'
require 'fountain/api/funnels'
require 'fountain/api/labels'
require 'fountain/api/notes'
require 'fountain/api/stages'
