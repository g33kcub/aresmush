module AresMUSH
  module FS3Skills
    class SheetTemplate < ErbTemplateRenderer

      attr_accessor :char

      def initialize(char, client)
        @char = char
        super File.dirname(__FILE__) + "/sheet.erb"
      end

      def approval_status
        Chargen.approval_status(@char)
      end

      def sanity_max
        @char.get_max_sanity
      end

      def will_max
        @char.get_max_will
      end

      def will_curr
        will_max - @char.will
      end

      def sanity_curr
        sanity_max - @char.sanity
      end

      def luck
        @char.luck.floor
      end

      def luck_max
        base = Global.read_config("fs3skills", "max_luck")
        adv = FS3Skills.ability_rating(@char, "Fortune Favored")
        max = base + adv
        max
      end

      def xp_max
        Global.read_config("fs3skills", "max_xp_hoard")
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
        @char.fs3_action_skills.sort_by(:name, :order => "Alpha").each_with_index do |a, i|
            list << format_skill(a, i)
        end
            list
      end

      def magix
       list = []
        @char.fs3_magix_arts.sort_by(:name, :order => "Alpha").each_with_index do |a, i|
            if a.rating_name != "Unskilled"
              list << format_magix(a, i)
            end
        end
        list
      end

      def background_skills
        list = []
        @char.fs3_background_skills.sort_by(:name, :order => "ALPHA").each_with_index do |s, i|
           list << format_adv_bg(s, i)
        end
        list
      end

      def languages
        list = []
        @char.fs3_languages.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_language(l, i)
        end
        list
      end

      def advantages
        list = []
        @char.fs3_advantages.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_adv_bg(l, i)
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

      def format_attr(a, i, show_linked_attr = false)
        name = "%xh#{a.name}:%xn"
        linked_attr = show_linked_attr ? print_linked_attr(a) : "   "
        linebreak = i % 2 == 1 ? "" : "%r"
        rating_text = "#{a.rating_name}"
        rating = "%xh#{a.print_rating}%xn"
        "#{linebreak}#{left(name, 16)} [#{rating}] #{linked_attr} #{left(rating_text,12)}"
      end

      def format_skill(s, i, show_linked_attr = true)
        name = "%xh#{s.name}:%xn"
        linked_attr = show_linked_attr ? print_linked_attr(s) : "   "
        linebreak = i % 2 == 1 ? "" : "%r"
        rating_text = "#{s.rating_name}"
        rating = "%xh#{s.print_rating}%xn"
        "#{linebreak}#{left(name, 16)} [#{rating}] #{linked_attr} #{left(rating_text,12)}"
      end

      def format_adv_bg(s, i, show_linked_attr = false)
        name = "%xh#{s.name}:%xn"
        linked_attr = show_linked_attr ? print_linked_attr(s) : "   "
        linebreak = i % 2 == 1 ? "" : "%r"
        rating_text = "#{s.rating_name}"
        rating = "#{s.print_rating}"
        "#{linebreak}#{left(name, 16)} [#{rating}] #{linked_attr} #{left(rating_text,12)}"
      end

      def format_language(s, i, show_linked_attr = false)
        name = "%xh#{s.name}%xn"
        linked_attr = show_linked_attr ? print_linked_attr(s) : "   "
        linebreak = i % 2 == 1 ? "" : "%r"
        rating_text = ""
        "#{linebreak}#{left(name, 16)} #{left(rating_text, 20)}"
      end

      def format_magix(s, i, show_linked_attr = true)
        name = "%xh#{s.name}:%xn"
        linked_attr = show_linked_attr ? print_linked_attr(s) : "   "
        linebreak = i % 2 == 1 ? "" : "%r"
        rating_text = "#{s.rating_name}"
        rating = "#{s.print_rating}"
        "#{linebreak}#{left(name, 16)} [#{rating}] #{linked_attr} #{left(rating_text,12)}"
      end

      def print_linked_attr(skill)
        apt = FS3Skills.get_linked_attr(skill.name)
        !apt ? "" : "%xh%xx#{apt[0..2].upcase}%xn"
      end

      def calling
        @char.group("Calling") || "Unknown"
      end

      def alignment
        @char.group("Alignment") || "Unknown"
      end

      def fullname
        @char.demographic("fullname") || "Unknown"
      end

      def shadowname
        @char.demographic("shadowname") || "Unknown"
      end

      def job
        @char.demographic("job") || "Unknown"
      end

      def motivation
        @char.group("motivation") || "Unknown"
      end

      def dateofbirth
          dob = @char.demographic("birthdate")
          !dob ? "Unknown" : ICTime.ic_datestr(dob)
      end

      def age
        age = @char.age
        age == 0 ? "--" : age
      end

      def game_name
        Global.read_config("game","name")
      end

    end
  end
end
