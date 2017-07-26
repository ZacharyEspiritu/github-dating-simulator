class GithubAnalyzer
  def initialize
    client_id     = ENV["github_client_id"]
    client_secret = ENV["github_client_secret"]
    basic_auth    = "#{ENV["github_requester_id"]}:#{ENV["github_requester_secret"]}"

    @github = Github.new(
      client_id:     client_id,
      client_secret: client_secret,
      user_agent:    "Github Dating Simulator",
      basic_auth:    basic_auth
    )
  end

  def analyze_users(users, number = 2)
    user_hash = {}
    users.each do |user|
      search = UserData.find_by(username: user)
      if search
        user_hash[user] = search.data
      else
        user_hash[user] = calculate_percents(user)
        avatar_url = ""
        begin
          avatar_url = @github.users.get(user: user).avatar_url
        rescue
          return false, false
        end
        UserData.create(username: user, data: user_hash[user], avatar_url: avatar_url)
      end
    end

    total = 0
    percent_languages = {}
    user_hash.each do |key, value|
      if user_hash[key]
        user_hash[key].each do |k, v|
          if percent_languages[k]
            percent_languages[k] += v
          else
            percent_languages[k] = v
          end
          total += v
        end
      end
    end
    percent_languages.sort_by {|_key, value| value}.to_h
    percent_languages.each do |key, value|
      percent_languages[key] = (value.to_f / total.to_f) * 100
    end

    if number == 2

      matches = []
      user_hash.length.times do |i|
        (user_hash.length - i - 1).times do |j|
          comparison_data = compare(user_hash[user_hash.keys[i]], user_hash[user_hash.keys[j + i + 1]])
          matches << [comparison_data.first, user_hash.keys[i], user_hash.keys[j + i + 1], comparison_data.second, comparison_data.third]
        end
      end

      matches.sort! { |a,b| a.first <=> b.first }.reverse!

      set_matches = []
      while matches.length > 0
        set_matches << matches.first
        index = 0
        matches.length.times do
          match = matches[index]
          if match.include?(set_matches.last.second) || match.include?(set_matches.last.third)
            matches.delete_at(index)
          else
            index += 1
          end
        end
      end

      set_matches.each do |match|
        if users.include?(match.second)
          users.delete_at(users.index(match.second))
        end

        if users.include?(match.third)
          users.delete_at(users.index(match.third))
        end
      end

      unless users.empty?
        set_matches << [0, users.first]
      end

      return set_matches, percent_languages.sort_by {|_key, value| value}.reverse


    elsif number == 3
      matches = []

      for i in 0..user_hash.length
        for j in (i + 1)..user_hash.length
          for k in (j + 1)..user_hash.length
            user1 = user_hash.keys[i]
            user2 = user_hash.keys[j]
            user3 = user_hash.keys[k]
            if user1 && user2 && user3
              comparison_data = compare(user_hash[user1], user_hash[user2], user_hash[user3])
              matches << [(comparison_data.first / 200.0) * 100, user1, user2, user3, comparison_data.second, comparison_data.third]
            end
          end
        end
      end
      matches.sort! { |a,b| a.first <=> b.first }.reverse!

      set_matches = []
      while matches.length > 0
        set_matches << matches.first
        index = 0
        matches.length.times do
          match = matches[index]
          if match.include?(set_matches.last.second) || match.include?(set_matches.last.third) || match.include?(set_matches.last.fourth)
            matches.delete_at(index)
          else
            index += 1
          end
        end
      end

      set_matches.each do |match|
        if users.include?(match.second)
          users.delete_at(users.index(match.second))
        end

        if users.include?(match.third)
          users.delete_at(users.index(match.third))
        end

        if users.include?(match.fourth)
          users.delete_at(users.index(match.fourth))
        end
      end

      unless users.empty?
        set_matches << [0, users.first]
      end

      return set_matches, percent_languages.sort_by {|_key, value| value}.reverse


    else # number == 4
      matches = []

      blacklist = []
      for i in 0..user_hash.length
        for j in (i + 1)..user_hash.length
          for k in (j + 1)..user_hash.length
            for m in (k + 1)..user_hash.length
              user1 = user_hash.keys[i]
              user2 = user_hash.keys[j]
              user3 = user_hash.keys[k]
              user4 = user_hash.keys[m]
              if user1 && user2 && user3 && user4
                comparison_data = compare(user_hash[user1], user_hash[user2], user_hash[user3], user_hash[user4])
                if (comparison_data.first / 300.0) * 100 > 88
                  blacklist << user1
                  blacklist << user2
                  blacklist << user3
                  blacklist << user4
                end
                matches << [(comparison_data.first / 300.0) * 100, user1, user2, user3, user4, comparison_data.second, comparison_data.third]
              end
            end
          end
        end
      end
      matches.sort! { |a,b| a.first <=> b.first }.reverse!

      set_matches = []
      while matches.length > 0
        set_matches << matches.first
        index = 0
        matches.length.times do
          match = matches[index]
          if match.include?(set_matches.last.second) || match.include?(set_matches.last.third) || match.include?(set_matches.last.fourth) || match.include?(set_matches.last.fifth)
            matches.delete_at(index)
          else
            index += 1
          end
        end
      end

      set_matches.each do |match|
        if users.include?(match.second)
          users.delete_at(users.index(match.second))
        end

        if users.include?(match.third)
          users.delete_at(users.index(match.third))
        end

        if users.include?(match.fourth)
          users.delete_at(users.index(match.fourth))
        end

        if users.include?(match.fifth)
          users.delete_at(users.index(match.fifth))
        end
      end

      unless users.empty?
        set_matches << [0, users.first]
      end

      return set_matches, percent_languages.sort_by {|_key, value| value}.reverse
    end
  end

  def calculate_percents(user)
    begin
      if user
        repositories = @github.repos.list user: user
        languages = []
        if repositories
          repositories.each do |repo|
            if repo.name
              languages << @github.repos.languages(user: user, repo: repo.name).to_hash
            end
          end

          unless languages.empty?
            languages = languages.inject{|memo, el| memo.merge( el ){|k, old_v, new_v| old_v + new_v}}

            total = 0
            percent_languages = {}
            languages.each do |key, value|
              total += value
            end
            languages.sort_by {|_key, value| value}.to_h
            languages.each do |key, value|
              percent_languages[key] = (value.to_f / total.to_f) * 100
            end
            percent_languages.sort_by {|_key, value| value}.to_h
          end
        end
      end
    rescue
      {"n/a" => 0}
    end
  end

  def compare(data_1, data_2, data_3 = nil, data_4 = nil)
    if data_4 && data_3
      unless data_1.empty? || data_2.empty? || data_3.empty? || data_4.empty?
        hashes = [data_1, data_2, data_3, data_4]

        hashes.sort_by { |k| k.length }.reverse

        similarity_hash = {}
        hashes[0].each do |key, value|
          if hashes[3].key?(key) && hashes[2].key?(key) && hashes[1].key?(key)
            calculated_value = (hashes[0][key] - (hashes[1][key] - (hashes[2][key] - (hashes[3][key] - hashes[2][key]).abs))).abs
            if calculated_value < 0
              calculated_value = 0
            end
            similarity_hash[key] = calculated_value
          else
            similarity_hash[key] = 0
          end
        end

        similarity_percentage = 0
        similarity_hash.each do |key, value|
          similarity_percentage += value
        end

        other_similarity_hash = {}
        hashes[0].each do |key, value|
          if hashes[3].key?(key) && hashes[2].key?(key) && hashes[1].key?(key)
            calculated_value = (hashes[0][key] - (hashes[1][key] - (hashes[2][key] - (hashes[3][key] - hashes[2][key]).abs))).abs
            if calculated_value < 0
              calculated_value = 0
            end
            other_similarity_hash[key] = calculated_value
          else
            other_similarity_hash[key] = 0
          end
        end

        other_similarity_percentage = 0
        other_similarity_hash.each do |key, value|
          other_similarity_percentage += value
        end

        ideas = generate_ideas(similarity_hash.sort_by {|_key, value| value}.reverse)

        [((other_similarity_percentage + similarity_percentage) / 2).round(2), ideas, similarity_hash.sort_by {|_key, value| value}.reverse.first.first]
      end
    elsif data_3
      unless data_1.empty? || data_2.empty? || data_3.empty?
        hashes = [data_1, data_2, data_3]
        longest_hash = data_1
        shortest_hash = data_3
        if longest_hash.length < data_2.length
          longest_hash = data_2
        end
        if longest_hash.length > data_2.length
          shortest_hash = data_2
        end
        if longest_hash.length < data_3.length
          longest_hash = data_3
        end
        if longest_hash.length > data_1.length
          shortest_hash = data_1
        end

        hashes.delete_at(hashes.index(longest_hash))
        hashes.delete_at(hashes.index(shortest_hash))
        middle_hash = hashes.first

        similarity_hash = {}
        longest_hash.each do |key, value|
          if shortest_hash.key?(key) && middle_hash.key?(key)
            calculated_value = (longest_hash[key] - (shortest_hash[key] - (middle_hash[key] - shortest_hash[key]).abs)).abs
            if calculated_value < 0
              calculated_value = 0
            end
            similarity_hash[key] = calculated_value
          else
            similarity_hash[key] = 0
          end
        end

        similarity_percentage = 0
        similarity_hash.each do |key, value|
          similarity_percentage += value
        end

        other_similarity_hash = {}
        longest_hash.each do |key, value|
          if shortest_hash.key?(key) && middle_hash.key?(key)
            calculated_value = (longest_hash[key] - (shortest_hash[key] - (middle_hash[key] - shortest_hash[key]).abs)).abs
            if calculated_value < 0
              calculated_value = 0
            end
            other_similarity_hash[key] = calculated_value
          else
            other_similarity_hash[key] = 0
          end
        end

        other_similarity_percentage = 0
        other_similarity_hash.each do |key, value|
          other_similarity_percentage += value
        end

        ideas = generate_ideas(similarity_hash.sort_by {|_key, value| value}.reverse)

        [((other_similarity_percentage + similarity_percentage) / 2).round(2), ideas, similarity_hash.sort_by {|_key, value| value}.reverse.first.first]
      end
    else
      unless data_1.empty? || data_2.empty?
        start_hash = data_1
        end_hash = data_2
        if data_2.length > data_1.length
          start_hash = data_2
          end_hash = data_1
        end

        similarity_hash = {}
        start_hash.each do |key, value|
          if end_hash.key?(key)
            calculated_value = (end_hash[key] - (start_hash[key] - end_hash[key]).abs).abs
            if calculated_value < 0
              calculated_value = 0
            end
            similarity_hash[key] = calculated_value
          else
            similarity_hash[key] = 0
          end
        end

        similarity_percentage = 0
        similarity_hash.each do |key, value|
          similarity_percentage += value
        end

        other_similarity_hash = {}
        start_hash.each do |key, value|
          if end_hash.key?(key)
            calculated_value = (start_hash[key] - (start_hash[key] - end_hash[key]).abs).abs
            if calculated_value < 0
              calculated_value = 0
            end
            other_similarity_hash[key] = calculated_value
          else
            other_similarity_hash[key] = 0
          end
        end

        other_similarity_percentage = 0
        other_similarity_hash.each do |key, value|
          other_similarity_percentage += value
        end

        ideas = generate_ideas(similarity_hash.sort_by {|_key, value| value}.reverse)

        [((other_similarity_percentage + similarity_percentage) / 2).round(2), ideas, similarity_hash.sort_by {|_key, value| value}.reverse.first.first]
      else
        [0, "", ""]
      end
    end
  end

  def generate_ideas(array)
    ideas = []
    array.each do |language|
      ideas << IdeaGenerator.generate_idea(language.first)
    end
    ideas
  end
end
