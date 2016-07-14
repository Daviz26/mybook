module PhotosHelper
  
  # Our new helper method
  def likers_of(photo)
    # votes variable is set to the likes by users.  
    votes = photo.votes_for.up.by_type(User)
    # set use_names variable as an empty array
    user_names = []

    # unless there are no likes, continue below.
    unless votes.blank?
      # iterate through the voters of each vote (the users who liked the post)
      votes.voters.each do |voter|
        # add the user_name as a link to the array
        user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: '')
      end
      # present the array as a nice sentence using the as_sentence method and also make it usable within our html.  
      #Then call the like_plural method with the votes variable we set earlier as the argument.


      if votes.count == 1 and current_user.voted_for? photo
        user_names[-1].replace("You")
        user_names.last.html_safe + " like this."
      else if votes.count == 1 
        (link_to user_names.last.html_safe, profile_path(user_names)) + " likes this."
      else if votes.count == 2 and current_user.voted_for? photo
        user_names[-1].replace("You") 
        user_names.last.html_safe + " and " + (link_to user_names.first.html_safe, profile_path(user_names)) + " like this."
      else if votes.count == 2 
        (link_to user_names.last.html_safe, profile_path(user_names)) + " and " + (link_to user_names.first.html_safe, profile_path(user_names)) + " like this."
      else if votes.count > 2 and current_user.voted_for? photo
        user_names[-1].replace("You")
        user_names.last.html_safe + ", " + (link_to user_names.first.html_safe, profile_path(user_names)) + " and" + " #{votes.count-2} others like this."
      else if votes.count > 2 
        (link_to user_names.last.html_safe, profile_path(user_names)) + ", " + (link_to user_names.first.html_safe, profile_path(user_names)) + " and" + " #{votes.count-2} others like this."
      end
      end
      end
      end
      end
      end
    
    else 
      " Be the first one to like this photo. "
    end
    
  end
  
  # For filling heart on click
  def liked_photo(photo)  
    return 'fa fa-heart' if current_user.voted_for? photo
    'fa fa-heart-o'
  end
  
    # For unfilling heart on click
  def unliked_photo(photo)  
    return 'fa fa-heart-o' if !current_user.voted_for? photo
    'fa fa-heart'
  end

  private

  #def like_plural(votes)
    # If we more than one like for a post, use ' like this'
    #return ' like this' if votes.count > 1 
    # Otherwise, return ' likes this'
    #' likes this'
  #end

  
end
