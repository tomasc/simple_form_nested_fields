module SimpleFormNestedFields
  class Bem
    E_PREFIX = '__'.freeze
    M_PREFIX = '--'.freeze

    # Bem.new(b: :simple_form_nested_fields, e: :items, m: :open).to_s
    # => "simple_form_nested_fields__items simple_form_nested_fields__items--open"
    def initialize(b: nil, e: nil, m: nil)
      @b = b
      @e = e
      @m = m
    end

    def to_s
      [b_class, e_class, m_classes].uniq.reject(&:blank?).join(' ')
    end

    private
    attr_reader :b, :e, :m

    def bem_classes
      [b_class, e_class, m_classes].uniq
    end

    def b_class
      return unless b.present?
      return if e.present?
      b.to_s
    end

    def e_class
      return unless e.present?
      [b.to_s, em_class_builder(e, E_PREFIX)].reject(&:blank?).join
    end

    def m_classes
      return unless m.present?
      [m].flatten.map do |modifier|
        [
          b.to_s,
          em_class_builder(e, E_PREFIX),
          em_class_builder(modifier, M_PREFIX)
        ].reject(&:blank?).join
      end
    end

    def em_class_builder(em, prefix)
      return unless em.present?
      "#{prefix}#{em.to_s}"
    end
  end
end
