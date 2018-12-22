require 'mongoid'

class MyDoc
  include Mongoid::Document

  embeds_many :titles, class_name: 'MyDoc::Title'
  accepts_nested_attributes_for :titles, allow_destroy: true

  embeds_many :texts, class_name: 'MyDoc::Text', order: :position.asc
  accepts_nested_attributes_for :texts, allow_destroy: true

  embeds_many :variants, class_name: 'MyDoc::Variant'
  accepts_nested_attributes_for :variants, allow_destroy: true

  class Title
    include Mongoid::Document
    field :body, type: String
    embedded_in :my_doc, class_name: 'MyDoc'
  end

  class Text
    include Mongoid::Document
    field :body, type: String
    field :position, type: Integer
    embedded_in :my_doc, class_name: 'MyDoc'
  end

  class Variant
    include Mongoid::Document
    field :body, type: String
    embedded_in :my_doc, class_name: 'MyDoc'

    class One < Variant
      field :one, type: String
    end

    class Two < Variant
      field :two, type: String
    end
  end
end
