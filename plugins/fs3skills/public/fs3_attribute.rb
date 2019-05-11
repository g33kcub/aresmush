module AresMUSH
  class FS3Attribute < Ohm::Model
    include ObjectModel
    include LearnableAbility

    reference :character, "AresMUSH::Character"
    attribute :name
    attribute :rating, :type => DataType::Integer, :default => 0

    index :name

    def print_rating
      case rating
      when 0
        return "0"
      when 1
        return "%xg1%xn"
      when 2
        return "%xg2%xn"
      when 3
        return "%xy3%xn"
      when 4
        return "%xr4%xn"
      when 5
        return "%xb5%xn"
      end
    end

    def rating_name
      case rating
      when 0
        return t('fs3skills.unskilled_rating')
      when 1
        return t('fs3skills.poor_rating')
      when 2
        return t('fs3skills.average_rating')
      when 3
        return t('fs3skills.good_rating')
      when 4
        return t('fs3skills.great_rating')
      when 5
        return t('fs3skills.exceptional_rating')
      end
    end
  end
end
