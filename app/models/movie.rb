class Movie < ActiveRecord::Base
    def self.with_ratings(ratings)
        if ratings == nil
            Movie.select("*")
        else
            rating_list = []
            ratings.keys.each { |k| rating_list.append(k.upcase) }
            Movie.where(rating: rating_list)
        end
    end

    def self.all_ratings
        return ['G','PG','PG-13','R']
    end

    def self.ratings_to_show(ratings)
        ratings_l = {}
        if ratings != nil
            ratings.each { |r, v| ratings_l.merge!(r => "1") }
        else
            ratings_l = {'G'=>"1", 'PG'=>"1", 'PG-13'=>"1", 'R'=>"1"}
        end

        return ratings_l
    end
end



