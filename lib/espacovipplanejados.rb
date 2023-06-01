# frozen_string_literal: true

require_relative 'espacovipplanejados/version'
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'

module Espacovipplanejados
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @lead = lead

        return "#{source_name} - São Caetano" if message['caetano']
        return "#{source_name} - Lapa" if message['lapa']
        return "#{source_name} - Pinheiros" if message['pinheiros']
        return "#{source_name} - Santana" if message['santana']

        source_name
      end

      def source_name
        @lead.source.name || ''
      end

      def message
        @lead.message&.downcase || ''
      end
    end
  end
end
