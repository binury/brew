# frozen_string_literal: true

require "formulary"

module Test
  module Helper
    module Formula
      def formula(name = "formula_name", path: Formulary.core_path(name), spec: :stable, alias_path: nil, &block)
        Class.new(::Formula, &block).new(name, path, spec, alias_path: alias_path)
      end

      # Use a stubbed {Formulary::FormulaLoader} to make a given formula be found
      # when loading from {Formulary} with `ref`.
      def stub_formula_loader(formula, ref = formula.full_name, call_original: false)
        allow(Formulary).to receive(:loader_for).and_call_original if call_original

        loader = double(get_formula: formula)
        allow(Formulary).to receive(:loader_for).with(ref, from: :keg, warn: false).and_return(loader)
        allow(Formulary).to receive(:loader_for).with(ref, from: nil, warn: true).and_return(loader)
      end
    end
  end
end
