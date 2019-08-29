module AresMUSH
  class FS3Sorcery < Ohm::Model
    include ObjectModel
    include LearnableAbility

    reference :character, "AresMUSH::Character"
    attribute :name
    attribute :rating, :type => DataType::Integer, :default => 0
    attribute :specialties, :type => DataType::Array, :default => []
    index :name

    def print_rating
      case rating
      when 0
          return ""
      when 1
        return "%xb@%xn"
      end
    end

    def rating_name
      case rating
      when 0
        return t('fs3skills.everyman_rating')
      when 1
        return t('fs3skills.exceptional_rating')
      end
    end
  end
end
