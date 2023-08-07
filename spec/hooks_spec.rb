require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:lead) do
    lead = OpenStruct.new
    lead.source = source
    lead.product = product
    lead.message = ''

    lead
  end

  let(:source) do
    source = OpenStruct.new
    source.name = 'Some Source'

    source
  end

  let(:product) do
    product = OpenStruct.new
    product.name = ''

    product
  end

  let(:switch_source) { described_class.switch_source(lead) }

  context 'when source does not change' do
    it 'returns original souce' do
      expect(switch_source).to eq('Some Source')
    end
  end

  context 'when lead is from Facebook' do
    before { source.name = 'Facebook - Espaço Vip Ambientes Planejados' }

    context 'when store come in message' do
      context 'when customer choose the São Caetano' do
        before { lead.message = 'em_qual_unidade_você_gostaria_de_ser_atendido(a)?: são_caetano' }

        it 'returns source - São Caetano unit' do
          expect(switch_source).to eq('Facebook - Espaço Vip Ambientes Planejados - São Caetano')
        end
      end

      context 'when customer choose the Lapa unit' do
        before { lead.message = 'em_qual_unidade_você_gostaria_de_ser_atendido(a)?: lapa' }

        it 'returns source - Lapa' do
          expect(switch_source).to eq('Facebook - Espaço Vip Ambientes Planejados - Lapa')
        end
      end

      context 'when customer choose the Pinheiros unit' do
        before { lead.message = 'em_qual_unidade_você_gostaria_de_ser_atendido(a)?: pinheiros' }

        it 'returns source - Pinheiros' do
          expect(switch_source).to eq('Facebook - Espaço Vip Ambientes Planejados - Pinheiros')
        end
      end

      context 'when customer choose the Santana unit' do
        before { lead.message = 'em_qual_unidade_você_gostaria_de_ser_atendido(a)?: santana' }

        it 'returns source - Santana' do
          expect(switch_source).to eq('Facebook - Espaço Vip Ambientes Planejados - Santana')
        end
      end
    end

    context 'when lead store come in product' do
      context 'when customer choose the Loja Pinheiros' do
        before { product.name = 'Loja Pinheiros - Móveis Planejados até 50%off * 26.06.2023' }

        it 'returns source - Pinheiros' do
          expect(switch_source).to eq('Facebook - Espaço Vip Ambientes Planejados - Pinheiros')
        end
      end

      context 'when customer choose the Loja São Caetano' do
        before { product.name = 'Loja São Caetano - Cozinha planejada 36x e 90 dias *07.07.23' }

        it 'returns source - Pinheiros' do
          expect(switch_source).to eq('Facebook - Espaço Vip Ambientes Planejados - São Caetano')
        end
      end

      context 'when customer choose the Loja Santana' do
        before { product.name = 'Loja Santana - Cozinha a partir 9.999 + lavanderia' }

        it 'returns source - Pinheiros' do
          expect(switch_source).to eq('Facebook - Espaço Vip Ambientes Planejados - Santana')
        end
      end
    end
  end
end
