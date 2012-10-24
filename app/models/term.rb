class Term
  include MongoMapper::EmbeddedDocument
  key :term, String
  key :term_freq, Float
  key :term_weight, Float
  attr_accessible :term,:term_freq,:term_weight
end
