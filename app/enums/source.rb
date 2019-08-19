# frozen_string_literal: true

class Source < ClassyEnum::Base
end

class Source::Nyt < Source
  def name
    'The New York Times'
  end
end
