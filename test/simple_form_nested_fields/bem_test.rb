require 'test_helper'

describe SimpleFormNestedFields::Bem do
  subject { SimpleFormNestedFields::Bem }

  it 'builds a bem style selector string' do
    subject.new(b: :text_block).to_s.must_equal 'text_block'
    subject.new(b: :text_block, e: :element).to_s.must_equal 'text_block__element'
    subject.new(b: :text_block, m: :modifier).to_s.must_equal 'text_block text_block--modifier'
    subject.new(b: :text_block, e: :element, m: :modifier).to_s.must_equal 'text_block__element text_block__element--modifier'
    subject.new(b: :text_block, m: [:modifier_one, :modifier_two]).to_s.must_equal 'text_block text_block--modifier_one text_block--modifier_two'
    subject.new(b: :text_block, e: :element, m: [:modifier_one, :modifier_two]).to_s.must_equal 'text_block__element text_block__element--modifier_one text_block__element--modifier_two'
  end
end
