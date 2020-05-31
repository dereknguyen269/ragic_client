require 'ragic_client/version'
require 'httparty'
require 'json'

module RagicClient
  class Error < StandardError; end
  module Config
    class << self
      attr_accessor :ragic_api_url
      attr_accessor :ragic_api_key

      def setup
        @ragic_api_url = ragic_api_url
        @ragic_api_key = ragic_api_key
      end
    end
    self.setup
  end

  def self.config(&block)
    if block_given?
      block.call(RagicClient::Config)
    else
      RagicClient::Config
    end
  end

  def self.ragic_base_api_url(ragic_id = nil)
    return "#{RagicClient::Config.ragic_api_url}/#{ragic_id}" if ragic_id

    RagicClient::Config.ragic_api_url
  end

  def self.headers
    {
      'Content-Type': 'application/json',
      'Authorization': RagicClient::Config.ragic_api_key
    }
  end

  def self.find(ragic_id)
    opts = {
      headers: RagicClient.headers
    }
    beauty_body HTTParty.get(ragic_base_api_url(ragic_id), opts), ragic_id: ragic_id
  end

  # https://www.ragic.com/intl/en/doc-api/9/Filter-Conditions
  def self.find_by(condition_hash = {})
    opts = {
      headers: RagicClient.headers
    }
    api_url = [ragic_base_api_url]
    return {
      status: false,
      msg: 'Invalid conditions params'
    } unless condition_hash.is_a?(Hash)
    index = 0
    condition_hash.each do |key, value|
      api_url.push("#{index.zero? ? '?' : '&'}where=#{key},eq,#{value}")
      index += 1
    end
    api_url = api_url.join('')
    beauty_body HTTParty.get(api_url, opts)
  end

  # https://www.ragic.com/intl/en/doc-api/20/Deleting-an-entry
  def self.delete(ragic_id)
    opts = {
      headers: RagicClient.headers
    }
    beauty_body HTTParty.delete(ragic_base_api_url(ragic_id), opts)
  end

  # https://www.ragic.com/intl/en/doc-api/15/Creating-a-New-Entry
  def self.create(params = {})
    ragic_params = { doDefaultValue: true, doLinkLoad: true }
    ragic_params = ragic_params.merge!(params)
    opts = {
      headers: RagicClient.headers,
      body: ragic_params.to_json
    }
    beauty_body HTTParty.post(ragic_base_api_url, opts)
  end

  # https://www.ragic.com/intl/en/doc-api/16/Modifying-an-Entry
  def self.update(ragic_id, params = {})
    opts = {
      headers: RagicClient.headers,
      body: params.to_json
    }
    beauty_body HTTParty.post(ragic_base_api_url(ragic_id), opts), is_update: true
  end

  def self.beauty_body(response, options = {})
    success = false
    status_code = response.code
    if status_code == 200
      begin
        body = JSON.parse(response.body) || {}
        data =
          if options[:is_update]
            body['data']
          elsif options[:ragic_id]
            body[options[:ragic_id].to_s]
          else
            body
          end
        success = true if body['status'] != 'ERROR'
        msg = 'Ragic ID Not Found.' if ragic_id
        msg = body['msg']&.gsub('&nbsp;', '') if data
      rescue
        msg = 'Error!'
      end
    else
      begin
        body = JSON.parse(response.body)
        msg = body['msg']&.gsub('&nbsp;', '')
      rescue
        msg = 'Error!'
      end
    end
    {
      status_code: status_code,
      success: success,
      data: data,
      msg: msg
    }.delete_if { |_k, v| v.nil? }
  end
end
