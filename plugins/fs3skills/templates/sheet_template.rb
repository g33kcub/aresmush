module AresMUSH
  module FS3Skills
    class SheetTemplate < ErbTemplateRenderer

      attr_accessor :char, :client

      def initialize(char, client)
        @char = char
        @client = client
        super File.dirname(__FILE__) + "/sheet.erb"
      end

      def approval_status
        Chargen.approval_status(@char)
      end

      def luck
        @char.luck.floor
      end

      def attrs
       list = []
        @char.fs3_attributes.sort_by(:name, :order => "ALPHA").each_with_index do |a, i|
          list << format_attr(a, i)
        end
        list
      end

      def action_skills
        list = []
        @char.fs3_action_skills.sort_by(:name, :order => "ALPHA").each_with_index do |s, i|
           list << format_skill(s, i, true)
        end
        list
      end

      def background_skills
        list = []
        @char.fs3_background_skills.sort_by(:name, :order => "ALPHA").each_with_index do |s, i|
           list << format_skill(s, i)
        end
        list
      end

      def languages
        list = []
        @char.fs3_languages.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_skill(l, i)
        end
        list
      end

      def advantages
        list = []
        @char.fs3_advantages.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_skill(l, i)
        end
        list
      end

      def sorcery
        list = []
        @char.fs3_sorcery.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_skill(l, i)
        end
        list
      end

      def use_advantages
        FS3Skills.use_advantages?
      end

      def specialties
        spec = {}
        @char.fs3_action_skills.each do |a|
          if (a.specialties)
            a.specialties.each do |s|
              spec[s] = a.name
            end
          end
        end
        return nil if (spec.keys.count == 0)
        spec.map { |spec, ability| "#{spec} (#{ability})"}.join(", ")
      end

      def format_attr(a, i)
        name = "%xh#{a.name}:%xn"
        linebreak = i % 2 == 1 ? "" : "%r"
        rating_text = "#{a.rating_name}"
        "#{linebreak}#{left(name, 14)} #{left(a.print_rating, 8)} #{left(rating_text,16)}"
      end

      def format_skill(s, i, show_linked_attr = false)
        name = "%xh#{s.name}:%xn"
        linked_attr = show_linked_attr ? print_linked_attr(s) : ""
        linebreak = i % 2 == 1 ? "" : "%r"
        rating_text = "#{s.rating_name}#{linked_attr}"
        "#{linebreak}#{left(name, 14)} #{left(s.print_rating, 8)} #{left(rating_text, 16)}"
      end

      def print_linked_attr(skill)
        apt = FS3Skills.get_linked_attr(skill.name)
        !apt ? "" : " %xh%xx(#{apt[0..2].upcase})%xn"
      end

      def section_line(title)
        @client.screen_reader ? title : line_with_text(title)
      end

      def kind
        @char.demographic("kind") || "Unknown"
      end

      def colony
        @char.demographic("colony") || "Unknown"
      end

      def background
        @char.demographic("background") || "Unknown"
      end

      def arcana
        @char.demographic("arcana") || "Unknown"
      end

      def virtue
        ar = @char.demographic("arcana") || "Unknown"
        a = "#{ar}".downcase.tr(" ","_")
        t('fs3skills.virtue_#{a}')
      end

      def hubris
        ar = @char.demographic("arcana") || "Unknown"
        a = "#{ar}".downcase.tr(" ","_")
        t('fs3skills.hubris_#{a}')
      end

      def quirk
        ar = @char.demographic("arcana") || "Unknown"
        a = "#{ar}".downcase.tr(" ","_")
        t('fs3skills.quirk_#{a}')
      end

    end
  end
end
