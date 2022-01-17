# frozen_string_literal: true

# Validation module
module Validation
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
