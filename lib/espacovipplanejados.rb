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

        return "#{source_name} - São Caetano" if sao_caetano?
        return "#{source_name} - Lapa" if lapa?
        return "#{source_name} - Pinheiros" if pinheiros?
        return "#{source_name} - Santana" if santana?

        source_name
      end

      def source_name
        @lead.source.name || ''
      end

      def message
        @lead.message&.downcase || ''
      end

      def product
        @lead.product&.name&.downcase || ''
      end

      def sao_caetano?
        message['caetano'] || product['caetano']
      end

      def lapa?
        message['lapa']
      end

      def pinheiros?
        message['pinheiros'] || product['pinheiros']
      end

      def santana?
        message['santana'] || product['santana']
      end
    end
  end
end
